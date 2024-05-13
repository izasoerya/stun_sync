import 'package:flutter/material.dart';

class MessageBoxHeight extends StatelessWidget {
  const MessageBoxHeight({
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
