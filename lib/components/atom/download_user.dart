import 'package:flutter/material.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'dart:io';

class Downloaduser extends StatelessWidget {
  final SQLiteDB database;
  const Downloaduser({Key? key, required this.database}) : super(key: key);

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
            SnackBar(
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
      child: Text('Download Database'),
    );
  }
}
