import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/unit_container.dart';
import 'package:stun_sync/components/atom/value_container.dart';

class HeightTab extends StatelessWidget {
  const HeightTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const TitleContainer(
              title: 'Height',
            ),
          ),
          const Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 10)),
              ValueContainer(value: '78.3'),
              Padding(padding: EdgeInsets.only(right: 5)),
              Column(
                children: [
                  SizedBox(height: 18),
                  UnitContainer(unit: 'cm'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
