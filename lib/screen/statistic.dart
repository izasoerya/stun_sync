import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/role_slider.dart';
import 'package:stun_sync/components/organism/heading_statistic.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeadingStatistic(),
        RoleSlider(),
      ],
    );
  }
}
