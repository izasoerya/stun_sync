// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class EditValueLD extends ConsumerWidget {
  const EditValueLD({super.key, required this.callBack});
  final Function() callBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        icon: const Icon(
          Icons.edit,
          color: Color(0xFF22577A),
        ),
        onPressed: () => _showEditDialog(context, ref));
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController(
      text: ref.watch(userProfileProvider).lingkarDada.toString(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Nilai Lingkar Lengan Atas',
              style: TextStyle(
                color: Color(0xFF22577A),
              )),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Masukkan nilai lingkar dada dalam cm',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal',
                  style: TextStyle(
                    color: Color(0xFF22577A),
                  )),
            ),
            TextButton(
              onPressed: () async {
                final double? newLingkarDada = double.tryParse(controller.text);
                if (newLingkarDada != null) {
                  try {
                    String userName = ref.watch(userProfileProvider).name;
                    print(
                        'Updating lingkar_dada for user: $userName to $newLingkarDada');
                    await SQLiteDB()
                        .updateUserLingkarDada(userName, newLingkarDada);

                    print('Update successful');

                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error updating database: $e');
                  }
                } else {
                  print('Invalid input: ${controller.text}');
                }
              },
              child: const Text(
                'Simpan',
                style: TextStyle(
                  color: Color(0xFF22577A),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
