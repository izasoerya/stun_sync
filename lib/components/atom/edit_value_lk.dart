import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class EditValueLK extends ConsumerWidget {
  const EditValueLK({
    super.key,
    required this.callBack,
  });
  final Function() callBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(
        Icons.edit,
        color: Color(0xFF22577A),
      ),
      onPressed: () {
        _showEditDialog(context, ref);
      },
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController(
      text: ref.watch(userProfileProvider).lingkarKepala.toString(),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Lingkar Kepala',
              style: TextStyle(
                color: Color(0xFF22577A),
              )),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Masukkan nilai lingkar kepala dalam satuan  cm',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batalkan',
                  style: TextStyle(
                    color: Color(0xFF22577A),
                  )),
            ),
            TextButton(
              onPressed: () async {
                final double? newLingkarKepala =
                    double.tryParse(controller.text);
                if (newLingkarKepala != null) {
                  try {
                    String userName = "${ref.watch(userProfileProvider).name}";
                    print(
                        'Updating lingkar_kepala for user: $userName to $newLingkarKepala for user profile');
                    await SQLiteDB()
                        .updateUserLingkarKepala(userName, newLingkarKepala);
                    print('Update successful');
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error updating database: $e');
                  }
                } else {
                  print('Invalid input: ${controller.text}');
                }
                callBack();
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
