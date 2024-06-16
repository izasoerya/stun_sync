import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/components/atom/download_user.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  final SQLiteDB sqLiteDB = const SQLiteDB();

  Future<void> _requestPermission() async {
    bool isGranted = false;
    while (!isGranted) {
      List<PermissionStatus> statuses = await Future.wait([
        Permission.storage.request(),
        Permission.manageExternalStorage.request(),
      ]);

      if (statuses[0].isGranted && statuses[1].isGranted) {
        print('All permissions granted');
        isGranted = true; // All permissions are granted, exit the loop
      } else {
        print('Permissions not granted. Requesting again...');
        openAppSettings(); // Consider prompting the user before opening settings
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _requestPermission());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Admin',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            PageRouter.router.go('/login');
          },
        ),
        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(34, 87, 122, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.6,
              child: DownloadUser(database: sqLiteDB),
            ),
          ],
        ),
      ),
    );
  }
}
