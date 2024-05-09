import 'package:flutter/material.dart';

class ValueContainer extends StatelessWidget {
  const ValueContainer({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        color: Color.fromRGBO(81, 111, 131, 1),
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
