import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/data_container.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/value_container.dart';

class HeightTab extends StatelessWidget {
  const HeightTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: TitleContainer(
              title: 'Height',
            ),
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 10)),
              ValueContainer(value: '78.3'),
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
