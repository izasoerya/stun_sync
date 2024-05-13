import 'package:flutter/material.dart';

class MessageBoxBmi extends StatelessWidget {
  const MessageBoxBmi({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    String label;
    Color barColor;

    if (height < 18.5) {
      label = 'Underweight';
      barColor = Colors.red;
    } else if (height <= 24.9 && height >= 18.5) {
      label = 'Normal';
      barColor = Colors.green;
    } else if (height <= 29.9 && height >= 25) {
      label = 'Overweight';
      barColor = Colors.blue;
    } else {
      label = 'Obese';
      barColor = Colors.purple;
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
