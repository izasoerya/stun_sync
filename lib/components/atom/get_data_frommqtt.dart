import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:stun_sync/service/user_profile_controller.dart';
import 'package:stun_sync/utils/mqtt_subs.dart'; // Import your MQQTSubs class

class getdatafrommqtt extends ConsumerWidget {
  const getdatafrommqtt({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ctx) {
    return Container(
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              final mqttSubs =
                  MQQTSubs(ctx: ctx); // Create an instance of MQQTSubs
              await mqttSubs
                  .connectAndSubscribe(); // Call the method to connect and subscribe to MQTT
            },
            child: Text('ambil data dari alat'),
          ),
        ],
      ),
    );
  }
}
