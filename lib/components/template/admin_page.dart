import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/components/atom/download_user.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final SQLiteDB sqLiteDB = const SQLiteDB();
  bool _isRequestingPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _requestPermission());
  }

  Future<void> _requestPermission() async {
    if (_isRequestingPermission) {
      return;
    }
    _isRequestingPermission = true;

    var storageStatus = await Permission.storage.status;
    var manageExternalStorageStatus =
        await Permission.manageExternalStorage.status;

    if (!storageStatus.isGranted || !manageExternalStorageStatus.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.manageExternalStorage
      ].request();

      if (statuses.values.every((status) => status.isGranted)) {
        print('All permissions granted');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Permissions required'),
            content: Text(
                'This app requires storage permissions to function properly. Please enable them in the app settings.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () =>
                    Navigator.of(context).pop(), // Close the dialog
              ),
            ],
          ),
        );
      }
    } else {
      print('All permissions already granted');
    }
    _isRequestingPermission = false; // Reset flag after request completes
  }

  @override
  Widget build(BuildContext context) {
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
            const Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  sqLiteDB.deleteDB();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: const Color.fromRGBO(0, 71, 118, 1),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.delete),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text('Delete Database'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
