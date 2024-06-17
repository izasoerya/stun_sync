import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stun_sync/service/database_controller.dart';

class DownloadUser extends StatelessWidget {
  final SQLiteDB database;
  const DownloadUser({super.key, required this.database});

  Future<bool> _downloadAndStoreExcel() async {
    try {
      // Ensure the database path and excel file path are correct
      String dbPath = await database.getPathDB();
      String downloadPath = '/storage/emulated/0/Download/stun_sync';
      String excelFilePath = '$downloadPath/stun_sync_database.xlsx';

      // Convert the database to an Excel file
      await database.convertDbToExcel(dbPath, excelFilePath);
      print('Successfully converted to Excel file and saved to $excelFilePath');
    } catch (e) {
      print('Error downloading database: $e');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (await _downloadAndStoreExcel()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Successfully downloaded the database',
                style: TextStyle(color: Color.fromRGBO(0, 71, 118, 1)),
              ),
              backgroundColor: Color.fromRGBO(128, 237, 153, 1),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to download the database',
                  style: TextStyle(color: Color.fromRGBO(0, 71, 118, 1))),
              backgroundColor: Color.fromRGBO(255, 0, 0, 1),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(128, 237, 153, 1),
        foregroundColor: Color.fromRGBO(0, 71, 118, 1),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
      ),
      child: Row(
        children: [
          Icon(Icons.download),
          Padding(padding: EdgeInsets.only(right: 20)),
          Text('Download Excel'),
        ],
      ),
    );
  }
}
