import 'package:flutter/material.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/components/atom/role_slider.dart';
import 'package:stun_sync/components/atom/text_field_design.dart';

bool isLoggedIn = false;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 87, 122, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome to Stun Sync',
            style: TextStyle(
              fontFamily: 'Poppins', // Add this line
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('Please login to continue',
              style: TextStyle(
                fontFamily: 'Poppins', // Add this line
                color: Color.fromRGBO(205, 205, 205, 1),
                fontSize: 16,
              )),
          const Padding(padding: EdgeInsets.only(top: 15)),
          const RoleSlider(),
          const Padding(padding: EdgeInsets.only(top: 15)),
          const TextFieldDesign(label: 'Username'),
          const Padding(padding: EdgeInsets.only(top: 15)),
          const TextFieldDesign(label: 'Password'),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Didnt have an account? ',
                  style: TextStyle(
                    fontFamily: 'Poppins', // Add this line
                    color: Colors.white,
                    fontSize: 16,
                  )),
              Text('Register here',
                  style: TextStyle(
                    fontFamily: 'Poppins', // Add this line
                    color: Color.fromRGBO(128, 237, 153, 1),
                    fontSize: 16,
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                isLoggedIn = true;
                PageRouter.router.go('/');
              },
              child: const Text('Login'),
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
            ),
          ),
        ],
      ),
    );
  }
}
