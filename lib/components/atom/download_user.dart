import 'package:flutter/material.dart';
import 'package:stun_sync/service/database_controller.dart';

class Downloaduser extends StatelessWidget {
  final SQLiteDB database;
  const Downloaduser({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      onPressed: () async {
        try {
          await database.downloadDB();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Database downloaded'),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error downloading database: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: const Text('Download Database'),
    );
  }
}
