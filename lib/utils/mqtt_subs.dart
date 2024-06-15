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
  final WidgetRef ctx;

  MQQTSubs({required this.ctx})
      : client = MqttServerClient.withPort(
          'ied8e792.ala.asia-southeast1.emqxsl.com',
          'flutter_client',
          8883,
        ),
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

  Future<int> connectAndSubscribe() async {
    if (!await attemptConnection()) return 400;
    if (!await subscribeToTopic()) return 402;
    return await processMessages() ? 200 : 401;
  }

  Future<bool> attemptConnection() async {
    try {
      await client.connect();
      return client.connectionStatus?.state == MqttConnectionState.connected;
    } catch (e) {
      client.disconnect();
      return false;
    }
  }

  Future<bool> subscribeToTopic() async {
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.subscribe('Height', MqttQos.atMostOnce);
      return true;
    } else {
      client.disconnect();
      return false;
    }
  }

  Future<bool> processMessages() async {
    final userProfile = ctx.read(userProfileProvider);
    final currentUser = await database.getUserByNameAndPassword(
        userProfile.name, userProfile.password);
    bool success = true;

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('pt: $pt');
      try {
        final mqttData = jsonDecode(pt);
        final user = database.fromMqttData(userProfile, mqttData);
        if (currentUser != null && currentUser.isSameDay(currentUser, user)) {
          database.updateUserDataWithHighestId(user);
        } else {
          database.insertUser(user);
        }
      } catch (e) {
        success = false;
      }
    });
    return success;
  }
}
