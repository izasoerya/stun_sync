import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/components/atom/download_user.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  final SQLiteDB sqLiteDB = const SQLiteDB();

  Future<void> _requestPermission() async {
    // Request both permissions simultaneously
    List<PermissionStatus> statuses = await Future.wait([
      Permission.storage.request(),
      Permission.manageExternalStorage.request(),
    ]);

    // Check the status of the first permission (storage)
    if (statuses[0].isGranted) {
      print('Storage permission granted');
    } else if (statuses[0].isDenied) {
      print('Storage permission denied');
    } else if (statuses[0].isPermanentlyDenied) {
      print('Storage permission permanently denied');
      openAppSettings(); // Consider moving this outside if you need to check both permissions
    }

    // Check the status of the second permission (manageExternalStorage)
    if (statuses[1].isGranted) {
      print('Manage external storage permission granted');
    } else if (statuses[1].isDenied) {
      print('Manage external storage permission denied');
    } else if (statuses[1].isPermanentlyDenied) {
      print('Manage external storage permission permanently denied');
      openAppSettings(); // This might be redundant if called above; adjust based on your logic
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _requestPermission());

    return Container(
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
    );
  }
}
