import 'package:flutter/material.dart';

class LinearGauge extends StatelessWidget {
  const LinearGauge({super.key, required this.gauge});
  final int gauge;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Stack(
        children: [
          LinearProgressIndicator(
            value: 70 / 100,
            minHeight: 10,
            color: Color.fromRGBO(123, 168, 198, 0.7),
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.grey[300],
          ),
          LinearProgressIndicator(
            value: 50 / 100,
            minHeight: 10,
            color: Color.fromRGBO(34, 87, 122, 1),
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
