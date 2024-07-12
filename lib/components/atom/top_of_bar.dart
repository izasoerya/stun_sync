import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class TopOfBar extends ConsumerWidget {
  const TopOfBar({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: PopupMenuButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 40,
                    ),
                    color: Colors.white,
                    offset: Offset(
                        -30, 60), // Adjust the offset to position the menu
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: Text('Keluar'),
                          value: 'logout',
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      if (value == 'logout') {
                        // Perform logout action
                        PageRouter.router.go('/login');
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Halo Orangtua ${ref.read(userProfileProvider).name}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
