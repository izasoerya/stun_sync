import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class MQQTSubs {
  final MqttServerClient client;
  final SQLiteDB database;
  final WidgetRef ref;
  final String mqttTopic = 'Height';

  MQQTSubs({required this.ref})
      : client = MqttServerClient.withPort(
            'k91ed63b.ala.us-east-1.emqxsl.com', 'flutter_client', 8883),
        database = const SQLiteDB() {
    client
      ..connectionMessage = MqttConnectMessage()
          .authenticateAs('device_1', 'device_1_admin')
          .withClientIdentifier('flutter_client')
          .startClean()
          .withWillQos(MqttQos.atMostOnce)
      ..secure = true
      ..onBadCertificate = (dynamic a) => true;
  }

  Future<bool> startProcessingMessages() async {
    try {
      await client.connect();
    } catch (e) {
      print('Error: $e');
      client.disconnect();
      return false;
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected to the broker!');
      client.subscribe(mqttTopic, MqttQos.atMostOnce);
    }
    return true;
  }

  void stopProcessingMessages() {
    client.unsubscribe(mqttTopic);
    client.disconnect();
  }

  Future<int> processMessages() async {
    final userProfile = ref.read(userProfileProvider);
    final currentUser = await database.getUserByNameAndPassword(
        userProfile.name, userProfile.password);
    int success = 200;

    final Completer<void> receivedFirstMessage = Completer<void>();
    if (!await startProcessingMessages()) {
      return 400; // Failed to connect to the broker
    }
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      if (!receivedFirstMessage.isCompleted) {
        receivedFirstMessage.complete();
      }

      final mqtt = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(mqtt.payload.message);
      print('Received message: $pt');
      try {
        final mqttData = jsonDecode(pt);
        final user = database.fromMqttData(userProfile, mqttData);
        if (currentUser != null && currentUser.isSameDay(currentUser, user)) {
          database.updateUserDataWithHighestId(user);
        } else {
          database.insertUser(user);
        }
      } catch (e) {
        success = 401;
      }
    });
    await receivedFirstMessage.future;

    stopProcessingMessages();
    return success;
  }
}
