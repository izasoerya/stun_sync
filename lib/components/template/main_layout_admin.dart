import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

import '../../utils/mqtt_pub.dart';

final _selectedIndex = StateProvider<int>((ref) => 0);

class MainLayoutAdmin extends ConsumerWidget {
  const MainLayoutAdmin({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String username = '${(userProfile).name}';
    // //call mqtt subs
    // MQTTService mqttService = MQTTService();
    // mqttService.connect(username);
    print("");
    return Scaffold(
      body: child,
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 33, 190, 161),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
            currentIndex: ref.watch(_selectedIndex),
            onTap: (index) {
              ref.read(_selectedIndex.notifier).state = index;
              if (index == 0) {
                PageRouter.router.go('/homeadmin');
              } else if (index == 1) {
                PageRouter.router.go('/settings');
              }
            },
          ),
          Positioned(
            // Behold the magic number!
            left: ((ref.watch(_selectedIndex) / 2) *
                    MediaQuery.of(context).size.width) +
                (MediaQuery.of(context).size.width / 11) -
                (MediaQuery.of(context).size.width / 32),
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 4,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
