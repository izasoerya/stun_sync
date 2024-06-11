import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:path/path.dart';
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

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected');
      const topicHeight = 'Height';
      client.subscribe(topicHeight, MqttQos.atMostOnce);

      final mydb = await database.openDB();
      // Fetch user profile data before entering the async context
      final UserProfile? currentUser = await database.getUserByNameAndPassword(
          mydb,
          ctx.read(userProfileProvider).name,
          ctx.read(userProfileProvider).password);

      // Assuming userProfileProvider is how you access userProfile in your app
      final userProfile = ctx.read(userProfileProvider);

      // Define a variable to track if data has been received
      bool dataReceived = false;

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('Received message: $pt from topic: ${c[0].topic}');
        try {
          Map<String, dynamic> mqttData = jsonDecode(pt);
          // Use the previously fetched userProfile data
          UserProfile user = UserProfile(
            name: userProfile.name,
            password: userProfile.password,
            age: userProfile.age,
            height: int.tryParse(mqttData['height'].toString()) ?? 0,
            weight: int.tryParse(mqttData['weight'].toString()) ?? 0,
            lingkarKepala: userProfile.lingkarKepala,
            lingkarDada: userProfile.lingkarDada,
            admin: userProfile.admin,
            datetime: DateTime.parse(mqttData['datetime']),
          );
          print(mqttData);

          if (currentUser != null &&
              currentUser.datetime.month == user.datetime.month &&
              currentUser.datetime.day == user.datetime.day) {
            print('User data already exists');
            database.updateUserDataWithHighestId(mydb, user);
          } else {
            database.insertUser(mydb, user);
          }

          // database.parseMQTTData(mqttData);

          // Unsubscribe from the topic after receiving the data
          if (!dataReceived) {
            dataReceived = true;
            client.unsubscribe(topicHeight);
            // Disconnect after a delay (e.g., 5 seconds)
            Future.delayed(Duration(seconds: 1), () {
              client.disconnect();
            });
          }
        } catch (e) {
          print('Error parsing MQTT data: $e');
        }
      });
    } else {
      print(
          'MQTT client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }
  }
}
