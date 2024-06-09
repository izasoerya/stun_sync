import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:async';

class MQQTSubs {
  final MqttServerClient client;

  MQQTSubs()
      : client = MqttServerClient.withPort(
          'k91ed63b.ala.us-east-1.emqxsl.com',
          'flutter_client',
          8883,
        ) {
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

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected');

      const topicHeight = 'Height';
      const topicWeight = 'Weight';
      client.subscribe(topicHeight, MqttQos.atMostOnce);
      client.subscribe(topicWeight, MqttQos.atMostOnce);
      print('kuda');

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('Received message: $pt from topic: ${c[0].topic}');
      });
      print("nasi");

      // Keep the client running for 60 seconds for demo purposes
      await Future.delayed(Duration(seconds: 60));
      print("haha");

      client.disconnect();
    } else {
      print(
          'MQTT client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }
    print("mama");
  }
}
