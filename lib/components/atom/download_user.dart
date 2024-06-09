import 'package:flutter/material.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'dart:io';

class Downloaduser extends StatelessWidget {
  final SQLiteDB database;
  const Downloaduser({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          File downloadedFile = await database.downloadDB();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Database downloaded: ${downloadedFile.path}'),
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
      child: Text('Download Database'),
    );
  }
}
