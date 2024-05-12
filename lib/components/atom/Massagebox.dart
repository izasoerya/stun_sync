import 'package:flutter/material.dart';
import 'package:stun_sync/service/user_profile_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/models/user_profile.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    String label;
    Color barColor;

    if (height <= 30) {
      label = 'Kurang Gizi';
      barColor = Colors.red;
    } else if (height <= 70) {
      label = 'Normal';
      barColor = Colors.green;
    } else {
      label = 'Surplus Gizi';
      barColor = Colors.blue;
    }
    return Container(
      width: 200,
      child: Stack(
        children: [
          Text(
            label,
            style: TextStyle(color: barColor),
          ), // Show the label
        ],
      ),
    );
  }
}
