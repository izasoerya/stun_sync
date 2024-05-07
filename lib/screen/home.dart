import 'package:flutter/material.dart';
import 'package:stun_sync/router/page_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Home Page!'),
        ElevatedButton(
          onPressed: () {
            PageRouter.router.go('/statistic');
          },
          child: Text('Go to Statistic Page'),
        )
      ],
    );
  }
}
