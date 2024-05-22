import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/models/page_index.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/utils/page_index_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 87, 122, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TitleContainer(
            title: 'Sign Up',
            fontSize: 24,
            color: Colors.white,
          ),
          ElevatedButton(
            onPressed: () {
              pageIndex = PageIndex.loginPage;
              PageRouter.router.go('/login');
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(34, 87, 122, 1)),
              backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(128, 237, 153, 1),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
