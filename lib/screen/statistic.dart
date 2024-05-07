import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/role_slider.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Angelia Emily'),
        RoleSlider(),
      ],
    );
  }
}
