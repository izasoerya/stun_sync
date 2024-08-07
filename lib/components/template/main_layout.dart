import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/router/page_router.dart';

final _selectedIndex = StateProvider<int>((ref) => 0);

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromRGBO(34, 87, 122, 1),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.table_chart_outlined),
                label: 'Statistik',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.info_outline),
              //   label: 'Information',
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.chat_outlined),
              //   label: 'Chat',
              // ),
            ],
            currentIndex: ref.watch(_selectedIndex),
            onTap: (index) {
              ref.read(_selectedIndex.notifier).state = index;
              if (index == 0) {
                PageRouter.router.go('/');
              } else if (index == 1) {
                PageRouter.router.go('/statistic');
              } else if (index == 2) {
                PageRouter.router.go('/information');
              }
            },
          ),
          Positioned(
            left: (ref.watch(_selectedIndex) *
                    (MediaQuery.of(context).size.width / 2)) +
                (MediaQuery.of(context).size.width / 4 -
                    50), // Adjusted for new width
            bottom: kBottomNavigationBarHeight, // Adjust this value as needed
            child: Container(
              width: 100, // Increased width
              height: 6, // Increased height
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
