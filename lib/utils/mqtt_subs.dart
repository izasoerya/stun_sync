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
  bool _shouldProcessMessages = false; // Flag to control message processing

  MQQTSubs({required this.ref})
      : client = MqttServerClient.withPort(
            'ied8e792.ala.asia-southeast1.emqxsl.com', 'flutter_client', 8883),
        database = const SQLiteDB() {
    _configureMQTTClient();
  }

  void _configureMQTTClient() {
    client
      ..connectionMessage = MqttConnectMessage()
          .authenticateAs('device_1', 'device_1_admin')
          .withClientIdentifier('flutter_client')
          .startClean()
          .withWillQos(MqttQos.atMostOnce)
      ..secure = true
      ..onBadCertificate = (dynamic a) => true;
  }

  // Call this method to start processing messages
  Future<void> startProcessingMessages() async {
    _shouldProcessMessages = true;
    try {
      await client.connect();
    } catch (e) {
      print('Error: $e');
      client.disconnect();
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected to the broker!');
      client.subscribe('Height', MqttQos.atMostOnce);
    }
  }

  // Call this method to stop processing messages
  void stopProcessingMessages() {
    _shouldProcessMessages = false;
    client.unsubscribe('Height'); // Unsubscribe from the topic
    client.disconnect(); // Disconnect the client
  }

  Future<int> processMessages() async {
    final userProfile = ref.read(userProfileProvider);
    final currentUser = await database.getUserByNameAndPassword(
        userProfile.name, userProfile.password);
    int success = 200;

    await startProcessingMessages();

    // Define a Completer that completes when the first message is received
    final Completer<void> receivedFirstMessage = Completer<void>();

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      if (!_shouldProcessMessages) return; // Check if processing is enabled
      if (!receivedFirstMessage.isCompleted) {
        receivedFirstMessage
            .complete(); // Complete the completer on the first message
      }

      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
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
        success = 400;
      }
    });

    // Wait for the first message to be received
    await receivedFirstMessage.future;

    print('Disconnecting...');
    stopProcessingMessages();
    return success;
  }
}
