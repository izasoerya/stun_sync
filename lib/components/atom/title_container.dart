import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  const TitleContainer({
    super.key,
    required this.title,
    this.fontSize = 18,
    this.color = const Color.fromRGBO(136, 136, 136, 1),
  });
  final String title;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
