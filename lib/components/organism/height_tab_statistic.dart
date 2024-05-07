import 'package:flutter/material.dart';

class HeightTab extends StatelessWidget {
  const HeightTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Height',
              style: TextStyle(
                color: Color.fromRGBO(136, 136, 136, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                '87,3',
                style: TextStyle(
                  color: Color.fromRGBO(81, 111, 131, 1),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 5)),
              Column(
                children: [
                  SizedBox(height: 18),
                  Text(
                    'cm',
                    style: TextStyle(
                      color: Color.fromRGBO(136, 136, 136, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
