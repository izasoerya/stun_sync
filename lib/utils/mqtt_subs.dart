import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:stun_sync/models/user_profile.dart';
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
        database = SQLiteDB() {
    // Initialize MQTT client
    client.connectionMessage = MqttConnectMessage()
        .authenticateAs('device_1', 'device_1_admin')
        .withClientIdentifier('flutter_client')
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    client.secure = true;
    client.onBadCertificate =
        (dynamic a) => true; // Bypass bad certificate for demo purposes
  }

  Future<void> connectAndSubscribe() async {
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
      return;
    }

    // Subscribe to MQTT topics
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected');
      const topicHeight = 'Height';
      client.subscribe(topicHeight, MqttQos.atMostOnce);

      final mydb = await database.openDB();
      List<UserProfile> users = await database.getUserByCredential(
          mydb,
          ctx.watch(userProfile).name,
          ctx.watch(userProfile).password,
          ctx.watch(userProfile).admin);
      // Assuming users is a List<UserProfile> and UserProfile has a DateTime property named dateTime
      UserProfile newestUser = users.reduce((currentNewest, next) =>
          next.datetime.isAfter(currentNewest.datetime) ? next : currentNewest);

      // Listen for MQTT messages
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('Received message: $pt from topic: ${c[0].topic}');
        try {
          Map<String, dynamic> mqttData = jsonDecode(pt);
          UserProfile user = UserProfile(
            name: ctx.watch(userProfile).name,
            password: ctx.watch(userProfile).password,
            age: ctx.watch(userProfile).age,
            height: int.tryParse(mqttData['height'].toString()) ?? 0,
            weight: int.tryParse(mqttData['weight'].toString()) ?? 0,
            lingkarKepala: ctx.watch(userProfile).lingkarKepala,
            lingkarDada: ctx.watch(userProfile).lingkarDada,
            admin: ctx.watch(userProfile).admin,
            datetime: DateTime.parse(mqttData['datetime']),
          );
          print(mqttData);
          database.insertUser(mydb, user);

          // database.parseMQTTData(mqttData);
        } catch (e) {
          print('Error parsing MQTT data: $e');
        }
      });

      // Keep the client running for 60 seconds for demo purposes
      await Future.delayed(Duration(seconds: 60));
      client.disconnect();
    } else {
      print(
          'MQTT client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }
  }
}
