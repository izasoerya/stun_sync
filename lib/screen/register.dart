// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:stun_sync/components/atom/date_picker.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:stun_sync/components/atom/button_auth.dart';
import 'package:stun_sync/components/atom/role_slider.dart';
import 'package:stun_sync/components/atom/text_field_design.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/utils/custom_snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  bool containsNonNumeric(String text) {
    final RegExp nonNumericRegExp = RegExp(r'[^0-9]');
    return nonNumericRegExp.hasMatch(text);
  }

  DateTime fetchDate(DateTime time) {
    return time;
  }

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final SQLiteDB sqLiteDB = const SQLiteDB();
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  DateTime age = DateTime.now();
  late Role selectedRole;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    selectedRole = Role.parent;
  }

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
            title: 'Buat Akun',
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
          const TitleContainer(
            title: 'Nama Lengkap',
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          const Padding(padding: EdgeInsets.only(top: 5)),
          TextFieldDesign(
            label: 'Nama Lengkap',
            visible: true,
            controller: usernameController,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const TitleContainer(
            title: 'Kata Sandi',
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          const Padding(padding: EdgeInsets.only(top: 5)),
          TextFieldDesign(
            label: 'Kata Sandi',
            visible: false,
            controller: passwordController,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const TitleContainer(
            title: 'Tanggal Lahir',
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          const Padding(padding: EdgeInsets.only(top: 5)),
          DatePicker(
            callBackDate: (DateTime date) {
              age = widget.fetchDate(date);
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          ButtonAuth(
            onPressed: () async {
              DateTime now = DateTime.now();
              int months = (now.year - age.year) * 12 +
                  now.month -
                  age.month -
                  (now.day < age.day ? 1 : 0);

              UserProfile userProfile = UserProfile(
                name: usernameController.text,
                password: passwordController.text,
                age: months, // Now age is in months
                height: 0,
                weight: 0,
                lingkarKepala: 0,
                lingkarDada: 0,
                admin: selectedRole == Role.posyandu ? true : false,
                datetime: now,
              );
              await sqLiteDB.insertUser(userProfile);
              const Utils().customSnackBar(context, 'Buat akun berhasil',
                  'Masuk untuk melanjutkan!', ContentType.success);
              PageRouter.router.go('/login');
            },
            label: 'Buat Akun',
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          GestureDetector(
            onTap: () {
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
