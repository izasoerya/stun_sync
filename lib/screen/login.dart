import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/components/atom/role_slider.dart';
import 'package:stun_sync/components/atom/text_field_design.dart';
import 'package:stun_sync/service/sqlite_db.dart';
import 'package:stun_sync/service/user_profile_data.dart';

bool isLoggedIn = false;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  final SQLiteDB sqLiteDB = const SQLiteDB();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

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
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('Please login to continue',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromRGBO(205, 205, 205, 1),
                fontSize: 16,
              )),
          const Padding(padding: EdgeInsets.only(top: 15)),
          const RoleSlider(),
          const Padding(padding: EdgeInsets.only(top: 15)),
          TextFieldDesign(label: 'Username', controller: usernameController),
          const Padding(padding: EdgeInsets.only(top: 15)),
          TextFieldDesign(label: 'Password', controller: passwordController),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Didnt have an account? ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 16,
                  )),
              Text('Register here',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromRGBO(128, 237, 153, 1),
                    fontSize: 16,
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                isLoggedIn = true;
                Database db = await widget.sqLiteDB.openDB();
                widget.sqLiteDB.showAllUsers(db);
                // widget.sqLiteDB.insertUser(
                //     db,
                //     const UserProfile(
                //       name: 'admin',
                //       password: 'admin',
                //       height: 190,
                //       weight: 85,
                //       age: 35,
                //       admin: true,
                //     ));
                final isUserExist = await widget.sqLiteDB.searchUser(
                    db, usernameController.text, passwordController.text);
                if (isUserExist) {
                  final user = UserProfile(
                    name: usernameController.text,
                    password: passwordController.text,
                    height: 190,
                    weight: 85,
                    age: 35,
                    admin: false,
                  );
                  ref.read(userProfile.notifier).setUser(user);
                  PageRouter.router.go('/');
                } else {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Login Gagal',
                      message: 'Preiksa kembali username dan password anda.',
                      contentType: ContentType.failure,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
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
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
