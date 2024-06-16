// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/utils/custom_snackbar.dart';
import 'package:stun_sync/utils/mqtt_subs.dart'; // Import your MQQTSubs class

class MqttDataFetcher extends ConsumerWidget {
  const MqttDataFetcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              final mqttSubs = MQQTSubs(ref: ref);
              int status = await mqttSubs.processMessages();
              switch (status) {
                case 400:
                  const Utils().customSnackBar(
                    context,
                    'Gagal',
                    'Pastikan anda memiliki sambungan Internet!',
                    ContentType.failure,
                  );
                  break;
                case 401:
                  const Utils().customSnackBar(
                    context,
                    'Gagal',
                    'Data tidak sesuai format!',
                    ContentType.failure,
                  );
                  break;
                default:
                  const Utils().customSnackBar(
                    context,
                    'Berhasil',
                    'Data berhasil diambil dari alat!',
                    ContentType.success,
                  );
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(34, 87, 122, 1),
              ),
            ),
            child: const Text(
              'ambil data dari alat',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
