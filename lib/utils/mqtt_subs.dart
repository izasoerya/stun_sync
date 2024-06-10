import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:stun_sync/service/database_controller.dart';

class MQQTSubs {
  final MqttServerClient client;
  final SQLiteDB database;

  MQQTSubs()
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
    // Connect to MQTT broker
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
      // Listen for MQTT messages
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('Received message: $pt from topic: ${c[0].topic}');

        // Parse MQTT data and save to SQLiteDB
        try {
          Map<String, dynamic> mqttData = jsonDecode(pt);
          database.parseMQTTData(mqttData);
          print("haha");

          // database.getUserByCredential(mydb, username, password, admin)
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
