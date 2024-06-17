import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Apakah anda yakin?'),
                        content: const Text(
                            'Aksi ini akan menghapus semua data. Data yang telah dihapus tidak dapat dipulihkan.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              sqLiteDB.deleteDB();
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
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
