import 'package:flutter/material.dart';
import 'package:stun_sync/router/page_router.dart';

bool isLoggedIn = false;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 87, 122, 1),
      ),
      child: Column(
        children: [
          const Text('Welcome to Stun Sync',
              style: TextStyle(
                color: Color.fromRGBO(136, 136, 136, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          ElevatedButton(
            onPressed: () {
              isLoggedIn = true;
              PageRouter.router.go('/');
            },
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
