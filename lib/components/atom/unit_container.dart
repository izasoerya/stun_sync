import 'package:flutter/material.dart';

class UnitContainer extends StatelessWidget {
  const UnitContainer({super.key, required this.unit});
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Text(
      unit,
      style: const TextStyle(
        color: Color.fromRGBO(136, 136, 136, 1),
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
