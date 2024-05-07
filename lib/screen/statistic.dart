import 'package:flutter/material.dart';
import 'package:stun_sync/router/page_router.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Statistic Page!'),
        ElevatedButton(
          onPressed: () {
            PageRouter.router.go('/');
          },
          child: Text('Go to Home Page'),
        )
      ],
    );
  }
}
