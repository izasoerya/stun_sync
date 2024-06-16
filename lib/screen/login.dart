import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:stun_sync/components/atom/button_auth.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/components/atom/role_slider.dart';
import 'package:stun_sync/components/atom/text_field_design.dart';
import 'package:stun_sync/service/auth_controller.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

bool isLoggedIn = false;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  final SQLiteDB sqLiteDB = const SQLiteDB();
  final AuthAPI authAPI = const AuthAPI();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  Role selectedRole = Role.parent;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _deteleBugAdmin() async {
    if (await widget.sqLiteDB.userIsExist('admin', 'admin', false) ||
        await widget.sqLiteDB.userIsExist('admin', 'admin', true)) {
      widget.sqLiteDB.deleteDB();
    }
  }

  @override
  Widget build(BuildContext context) {
    _deteleBugAdmin();
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 87, 122, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TitleContainer(
              title: 'Selamat Datang', fontSize: 24, color: Colors.white),
          const TitleContainer(
              title: 'Masuk untuk melanjutkan',
              fontSize: 12,
              color: Color.fromRGBO(205, 205, 205, 1)),
          const Padding(padding: EdgeInsets.only(top: 15)),
          RoleSlider(
            callBackRole: (role) {
              selectedRole = const AuthAPI().callBackRole(role);
              return role;
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          TextFieldDesign(
              label: 'Nama Lengkap',
              visible: true,
              controller: usernameController),
          const Padding(padding: EdgeInsets.only(top: 15)),
          TextFieldDesign(
              label: 'Kata Sandi',
              visible: false,
              controller: passwordController),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleContainer(
                  title: 'Tidak memiliki akun? ',
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white),
              GestureDetector(
                onTap: () {
                  PageRouter.router.go('/register');
                },
                child: const TitleContainer(
                    title: 'Daftar disini',
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color.fromRGBO(128, 237, 153, 1)),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          ButtonAuth(
              onPressed: () async {
                isLoggedIn = true;
                final isUserExist = await widget.sqLiteDB.userIsExist(
                  usernameController.text,
                  passwordController.text,
                  selectedRole == Role.posyandu ? true : false,
                );
                if (isUserExist) {
                  UserProfile? newestUser = await widget.sqLiteDB
                      .getUserByNameAndPassword(
                          usernameController.text, passwordController.text);

                  // Use a null-aware operator (?.) to access `height`, providing a fallback value if `newestUser` is null.
                  final user = UserProfile(
                    name: usernameController.text,
                    password: passwordController.text,
                    height: newestUser?.height ??
                        0, // Fallback to 0 if newestUser is null
                    weight: newestUser?.weight ??
                        0, // Fallback to 0 if newestUser is null
                    age: newestUser?.age ?? 0,
                    lingkarKepala: newestUser?.lingkarKepala ?? 0,
                    lingkarDada: newestUser?.lingkarDada ?? 0,
                    admin: newestUser?.admin ?? false,
                    datetime: newestUser?.datetime ?? DateTime.now(),
                  );
                  ref.read(userProfileProvider.notifier).setUser(user);
                  if (user.admin == true) {
                    PageRouter.router.go('/admin');
                  } else if (user.admin == false) {
                    PageRouter.router.go('/');
                  }
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
                // widget.sqLiteDB.deleteDB();
                widget.sqLiteDB.showUserProfileTable();
              },
              label: 'Masuk'),
          const Padding(padding: EdgeInsets.only(top: 10)),
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
