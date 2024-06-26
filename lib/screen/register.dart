// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:stun_sync/components/atom/date_picker.dart';
import 'package:stun_sync/components/atom/gender_selection.dart';
import 'package:stun_sync/components/atom/posyandu_selection.dart';
import 'package:stun_sync/models/admin_profile.dart';
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
  final SQLiteDB sqLiteDB = const SQLiteDB();

  int calculateAgeInMonths(DateTime birthDate) {
    final DateTime now = DateTime.now();
    int months = (now.year - birthDate.year) * 12 +
        now.month -
        birthDate.month -
        (now.day < birthDate.day ? 1 : 0);
    return months;
  }

  DateTime fetchDate(DateTime time) => time;
  bool fetchGender(bool isMale) => isMale;
  String fetchPosyandu(String name) => name;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  bool isMale = true;
  Role selectedRole = Role.parent;
  String posyanduName = '';
  DateTime age = DateTime.now();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
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
              setState(() {
                selectedRole = role;
              });
            },
          ),
          if (selectedRole == Role.parent) ...[
            const Padding(padding: EdgeInsets.only(top: 25)),
            const TitleContainer(
              title: 'Asal Posyandu',
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            PosyanduSelection(callback: (String name) {
              posyanduName = widget.fetchPosyandu(name);
            }),
            const Padding(padding: EdgeInsets.only(top: 10)),
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
              title: 'Tanggal Lahir & Jenis Kelamin',
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            SizedBox(
              width: 255,
              height: 40,
              child: Row(
                children: [
                  DatePicker(
                    callBackDate: (DateTime date) {
                      age = widget.fetchDate(date);
                    },
                  ),
                  const Spacer(),
                  GenderSelection(
                    isMale: (bool gender) {
                      isMale = widget.fetchGender(gender);
                    },
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            ButtonAuth(
              onPressed: () async {
                DateTime now = DateTime.now();
                UserProfile userProfile = UserProfile(
                  name: usernameController.text,
                  password: passwordController.text,
                  age: widget.calculateAgeInMonths(age),
                  height: 0,
                  weight: 0,
                  lingkarKepala: 0,
                  lingkarDada: 0,
                  admin: selectedRole == Role.posyandu ? true : false,
                  datetime: now,
                  dateOfBirth: age,
                  isMale: isMale,
                  posyandu: posyanduName,
                );
                await widget.sqLiteDB.insertUser(userProfile);
                PageRouter.router.go('/login');
                const Utils().customSnackBar(context, 'Buat akun berhasil',
                    'Masuk untuk melanjutkan!', ContentType.success);
              },
              label: 'Buat Akun',
            ),
          ] else ...[
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
            const Padding(padding: EdgeInsets.only(top: 30)),
            ButtonAuth(
              onPressed: () async {
                AdminProfile adminProfile = AdminProfile(
                  name: usernameController.text,
                  password: passwordController.text,
                  admin: selectedRole == Role.posyandu ? true : false,
                );
                await widget.sqLiteDB.insertAdmin(adminProfile);
                PageRouter.router.go('/login');
                const Utils().customSnackBar(context, 'Buat akun berhasil',
                    'Masuk untuk melanjutkan!', ContentType.success);
              },
              label: 'Buat Akun',
            ),
          ],
          const Padding(padding: EdgeInsets.only(top: 15)),
          GestureDetector(
            onTap: () => PageRouter.router.go('/login'),
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
