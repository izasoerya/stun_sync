import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/service/user_profile_controller.dart';
import 'package:stun_sync/utils/mqtt_subs.dart'; // Import your MQQTSubs class

class getdatafrommqtt extends ConsumerWidget {
  const getdatafrommqtt({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ctx) {
    // Get screen size
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      color: Colors.white, // Set the background color to white
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final mqttSubs =
                  MQQTSubs(ctx: ctx); // Create an instance of MQQTSubs
              await mqttSubs
                  .connectAndSubscribe(); // Call the method to connect and subscribe to MQTT
            },
            child: Text(
              'ambil data dari alat',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(34, 87, 122, 1),
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
