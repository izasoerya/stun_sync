import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/role_slider.dart';
import 'package:stun_sync/components/organism/heading_statistic.dart';
import 'package:stun_sync/components/organism/height_tab_statistic.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(238, 238, 238, 1),
      child: const Column(
        children: [
          HeadingStatistic(),
          RoleSlider(),
          HeightTab(),
        ],
      ),
    );
  }
}
