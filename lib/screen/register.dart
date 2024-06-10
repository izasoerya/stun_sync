import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  bool containsNonNumeric(String text) {
    // Define the regular expression for non-numeric characters
    final RegExp nonNumericRegExp = RegExp(r'[^0-9]');

    // Check if the text contains non-numeric characters
    return nonNumericRegExp.hasMatch(text);
  }

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final SQLiteDB sqLiteDB = const SQLiteDB();
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController ageController;

  late Role selectedRole;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    ageController = TextEditingController();

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
          TextFieldDesign(
            label: 'Nama Lengkap',
            visible: true,
            controller: usernameController,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          TextFieldDesign(
            label: 'Kata Sandi',
            visible: false,
            controller: passwordController,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          TextFieldDesign(
              label: 'Umur', visible: true, controller: ageController),
          const Padding(padding: EdgeInsets.only(top: 30)),
          ButtonAuth(
              onPressed: () async {
                if (widget.containsNonNumeric(ageController.text)) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Tidak valid!',
                      message: 'Umur harus berupa angka!',
                      contentType: ContentType.warning,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                  return;
                }
                pageIndex = PageIndex.loginPage;
                Database db = await sqLiteDB.openDB();
                DateTime now = DateTime.now();
                UserProfile userProfile = UserProfile(
                  name: usernameController.text,
                  password: passwordController.text,
                  age: int.parse(ageController.text),
                  height: 0,
                  weight: 0,
                  lingkarKepala: 0,
                  lingkarDada: 0,
                  admin: selectedRole == Role.puskesmas ? true : false,
                  datetime: now,
                );
                await sqLiteDB.insertUser(db, userProfile);
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Buat akun berhasil!',
                    message: 'Login untuk melanjutkan ke aplikasi',
                    contentType: ContentType.success,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
                PageRouter.router.go('/login');
              },
              label: 'Buat Akun'),
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
