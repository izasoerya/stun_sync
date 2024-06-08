import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      text: ref.watch(userProfile).height.toString(),
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
                //if (newHeight != null) {
                Navigator.of(context).pop();
              },
              child: const Text('Save',
                  style: TextStyle(
                    color: Color(0xFF22577A),
                  )),
            ),
          ],
        );
      },
    );
  }
}
