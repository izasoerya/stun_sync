import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stun_sync/service/database_controller.dart';

class DownloadUser extends StatelessWidget {
  final SQLiteDB database;
  const DownloadUser({super.key, required this.database});

  Future<void> _downloadAndStoreExcel() async {
    try {
      // Ensure the database path and excel file path are correct
      String dbPath = await database.getPathDB();
      String downloadPath = '/storage/emulated/0/Download/stun_sync';
      String excelFilePath = '$downloadPath/stun_sync_database.xlsx';

      // Convert the database to an Excel file
      await database.convertDbToExcel(dbPath, excelFilePath);

      print('successfully converted to Excel file and saved to $excelFilePath');
    } catch (e) {
      print('Error downloading database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _downloadAndStoreExcel,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Download User Data'),
    );
  }
}
