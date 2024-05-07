import 'package:flutter/material.dart';
import 'package:stun_sync/router/page_router.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart_outlined),
              label: 'Statistic',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              PageRouter.router.go('/');
            } else {
              PageRouter.router.go('/statistic');
            }
          },
        ));
  }
}
