import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class EditValue extends ConsumerWidget {
  const EditValue({super.key});

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
      text: ref.watch(userProfileProvider).height.toString(),
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
                final double? newHeight = double.tryParse(controller.text);
                if (newHeight != null) {
                  // Assuming you have access to the user's name (replace 'John Doe' with actual name)
                  String userName = "${ref.watch(userProfileProvider).name}";

                  // Call the updateUserHeight method to update the user's height
                  await SQLiteDB().updateUserHeight(
                      await SQLiteDB().openDB(), userName, newHeight);

                  // Close the current screen after updating the height
                  Navigator.of(context).pop();
                } else {
                  // Handle case where the entered height is not a valid number
                  // You may want to display an error message or take other action
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
