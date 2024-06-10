import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class EditValueLD extends ConsumerWidget {
  const EditValueLD({super.key});

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
      text: ref.watch(userProfileProvider).lingkarDada.toString(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Height',
              style: TextStyle(
                color: Color(0xFF22577A),
              )),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter new value in cm',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(
                    color: Color(0xFF22577A),
                  )),
            ),
            TextButton(
              onPressed: () async {
                final int? newLingkarDada = int.tryParse(controller.text);
                if (newLingkarDada != null) {
                  try {
                    // Assuming you have access to the user's name (replace 'John Doe' with actual name)
                    String userName = "${ref.watch(userProfileProvider).name}";

                    // Log the new value and user name for debugging
                    print(
                        'Updating lingkar_dada for user: $userName to $newLingkarDada');

                    // Call the updateUserLingkarDada method to update the user's
                    final db = await SQLiteDB().openDB();
                    await SQLiteDB()
                        .updateUserLingkarDada(db, userName, newLingkarDada);

                    // Log a success message
                    print('Update successful');

                    // Close the current screen after updating the lingkar_dada
                    Navigator.of(context).pop();
                  } catch (e) {
                    // Handle any errors that occur during the update
                    print('Error updating database: $e');
                    // Optionally, display an error message to the user
                  }
                } else {
                  // Handle case where the entered value is not a valid number
                  print('Invalid input: ${controller.text}');
                  // Optionally, display an error message to the user
                }
              },
              child: const Text(
                'Save',
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
