import 'package:flutter/material.dart';

class HeadingStatistic extends StatelessWidget {
  const HeadingStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: const Column(
        children: [
          Text(
            'Angelia Emily',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(34, 87, 152, 1),
            ),
          ),
          Text(
            '2 Year Old',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(34, 87, 152, 1),
            ),
          ),
        ],
      ),
    );
  }
}
