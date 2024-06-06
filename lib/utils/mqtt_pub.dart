import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTService {
  final String serverUrl =
      '4e73718ff42e4daf97e37f4c23bfa3db.s1.eu.hivemq.cloud';
  final int port = 8883;
  final String username = 'Admin';
  final String password = 'Admin123';

  MqttServerClient? client;
  Function(String topic, String message)? onMessageReceived;

  MQTTService({this.onMessageReceived});

  Future<void> connect(String clientId) async {
    client = MqttServerClient.withPort(serverUrl, clientId, port);
    client!.logging(on: true);

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .authenticateAs(username, password)
        .withWillQos(MqttQos.atLeastOnce);
    client!.connectionMessage = connMessage;

    try {
      await client!.connect();
      print('Connected to the MQTT broker.');
      subscribeToTopics(clientId);
    } catch (e) {
      print('Exception: $e');
      disconnect();
    }
  }

  void subscribeToTopics(String clientId) {
    if (client != null) {
      client!.subscribe('$clientId/Height', MqttQos.atLeastOnce);
      client!.subscribe('$clientId/Weight', MqttQos.atLeastOnce);
      client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);

        print('Received message:$payload from topic: ${c[0].topic}>');

        if (onMessageReceived != null) {
          onMessageReceived!(c[0].topic, payload);
        }
      });
    }
  }

  void publishMessage(String clientId, String topic, String message) {
    if (client != null) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client!.publishMessage(
          '$clientId/$topic', MqttQos.exactlyOnce, builder.payload!);
      print('Published message:$message to topic: $clientId/$topic');
    }
  }

  void disconnect() {
    client?.disconnect();
    print('Disconnected from the MQTT broker.');
  }
}
