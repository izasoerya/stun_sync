import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  const TitleContainer({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromRGBO(136, 136, 136, 1),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
