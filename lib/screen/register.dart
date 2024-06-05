import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/utils/page_index_controller.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/models/page_index.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:stun_sync/components/atom/button_auth.dart';
import 'package:stun_sync/components/atom/role_slider.dart';
import 'package:stun_sync/components/atom/text_field_design.dart';
import 'package:stun_sync/components/atom/title_container.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  final SQLiteDB sqLiteDB = const SQLiteDB();

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    Role selectedRole = Role.parent;

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
          const Padding(padding: EdgeInsets.only(top: 15)),
          RoleSlider(
            callBackRole: (role) {
              selectedRole = role;
              return role;
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 25)),
          TextFieldDesign(label: 'Username', controller: usernameController),
          const Padding(padding: EdgeInsets.only(top: 10)),
          TextFieldDesign(label: 'Password', controller: passwordController),
          const Padding(padding: EdgeInsets.only(top: 10)),
          TextFieldDesign(label: 'Age', controller: ageController),
          const Padding(padding: EdgeInsets.only(top: 30)),
          ButtonAuth(
              onPressed: () async {
                pageIndex = PageIndex.loginPage;
                Database db = await sqLiteDB.openDB();
                UserProfile userProfile = UserProfile(
                  name: usernameController.text,
                  password: passwordController.text,
                  age: int.parse(ageController.text),
                  height: 0,
                  weight: 0,
                  lingkarKepala: 0,
                  lingkarDada: 0,
                  admin: selectedRole == Role.puskesmas ? true : false,
                );
                await sqLiteDB.insertUser(db, userProfile);
                PageRouter.router.go('/login');
              },
              label: 'Sign Up'),
          const Padding(padding: EdgeInsets.only(top: 15)),
          GestureDetector(
            onTap: () {
              pageIndex = PageIndex.loginPage;
              PageRouter.router.go('/login');
            },
            child: const TitleContainer(
                title: 'Sudah memiliki Akun?',
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
