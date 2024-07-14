import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class Bbbulan extends ConsumerWidget {
  const Bbbulan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Contoh input umur dan berat badan
    int umur = ref.watch(userProfileProvider).age; // contoh umur dalam bulan
    double beratBadan =
        ref.watch(userProfileProvider).weight; // contoh berat badan dalam kg
    bool gender = ref.watch(userProfileProvider).isMale;
    double screenWidth = MediaQuery.of(context).size.width;

    // Memanggil fungsi getKategoriGizi
    String kategoriGizi = getKategoriGizi(gender, umur, beratBadan);

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth *
                  0.4, // Adjusting the width to 80% of screen width
              padding: EdgeInsets.all(16.0),

              child: Column(
                children: [
                  Text(
                    kategoriGizi,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: getKategoriColor(kategoriGizi),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getKategoriColor(String kategori) {
    switch (kategori) {
      case 'Berat badan sangat kurang':
        return Colors.red;
      case 'Berat badan kurang':
        return Colors.orange;
      case 'Berat badan normal':
        return Colors.green;
      case 'Risiko Berat badan lebih':
        return Colors.orange;
      case 'Berat badan Obesitas Berat':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  List<List<double>> _getMaleTable() {
    return [
      [2.1, 2.5, 2.9, 3.3, 3.9, 4.4, 5.0], // 0 bulan
      [2.9, 3.4, 3.9, 4.5, 5.1, 5.8, 6.6], // 1 bulan
      [3.8, 4.3, 4.9, 5.6, 6.3, 7.1, 8.0], // 2 bulan
      [4.4, 5.0, 5.7, 6.4, 7.2, 8.0, 9.0], // 3 bulan
      [4.9, 5.6, 6.2, 7.0, 7.8, 8.7, 9.7], // 4 bulan
      [5.3, 6.0, 6.7, 7.5, 8.4, 9.3, 10.4], // 5 bulan
      [5.7, 6.4, 7.1, 7.9, 8.8, 9.8, 10.9], // 6 bulan
      [5.9, 6.7, 7.4, 8.3, 9.2, 10.3, 11.4], // 7 bulan
      [6.2, 6.9, 7.7, 8.6, 9.6, 10.7, 11.9], // 8 bulan
      [6.4, 7.1, 8.0, 8.9, 9.9, 11.0, 12.3], // 9 bulan
      [6.6, 7.4, 8.2, 9.2, 10.2, 11.4, 12.7], // 10 bulan
      [6.8, 7.6, 8.4, 9.4, 10.5, 11.7, 13.0], // 11 bulan
      [6.9, 7.7, 8.6, 9.6, 10.8, 12.0, 13.3], // 12 bulan
      [7.1, 7.9, 8.8, 9.9, 11.0, 12.3, 13.7], // 13 bulan
      [7.2, 8.1, 9.0, 10.1, 11.3, 12.6, 14.0], // 14 bulan
      [7.4, 8.3, 9.2, 10.3, 11.5, 12.8, 14.3], // 15 bulan
      [7.5, 8.4, 9.4, 10.5, 11.7, 13.1, 14.6], // 16 bulan
      [7.7, 8.6, 9.6, 10.7, 12.0, 13.4, 14.9], // 17 bulan
      [7.8, 8.8, 9.8, 10.9, 12.2, 13.7, 15.3], // 18 bulan
      [8.0, 8.9, 10.0, 11.1, 12.5, 13.9, 15.6], // 19 bulan
      [8.1, 9.1, 10.1, 11.3, 12.7, 14.2, 15.9], // 20 bulan
      [8.2, 9.2, 10.3, 11.5, 12.9, 14.5, 16.2], // 21 bulan
      [8.4, 9.4, 10.5, 11.8, 13.2, 14.7, 16.5], // 22 bulan
      [8.5, 9.5, 10.7, 12.0, 13.4, 15.0, 16.8], // 23 bulan
      [8.6, 9.7, 10.8, 12.2, 13.6, 15.3, 17.1], // 24 bulan
      [8.8, 9.8, 11.0, 12.4, 13.9, 15.5, 17.5], // 25 bulan
      [8.9, 10.0, 11.2, 12.5, 14.1, 15.8, 17.8], // 26 bulan
      [9.0, 10.1, 11.3, 12.7, 14.3, 16.1, 18.1], // 27 bulan
      [9.1, 10.2, 11.5, 12.9, 14.5, 16.3, 18.4], // 28 bulan
      [9.2, 10.4, 11.7, 13.1, 14.8, 16.6, 18.7], // 29 bulan
      [9.4, 10.5, 11.8, 13.3, 15.0, 16.9, 19.0], // 30 bulan
      [9.5, 10.7, 12.0, 13.5, 15.2, 17.1, 19.3], // 31 bulan
      [9.6, 10.8, 12.1, 13.7, 15.4, 17.4, 19.6], // 32 bulan
      [9.7, 10.9, 12.3, 13.8, 15.6, 17.6, 19.9], // 33 bulan
      [9.8, 11.0, 12.4, 14.0, 15.8, 17.8, 20.2], // 34 bulan
      [9.9, 11.2, 12.6, 14.2, 16.0, 18.1, 20.4], // 35 bulan
      [10.0, 11.3, 12.7, 14.3, 16.2, 18.3, 20.7], // 36 bulan
      [10.1, 11.4, 12.9, 14.5, 16.4, 18.6, 21.0], // 37 bulan
      [10.2, 11.5, 13.0, 14.7, 16.6, 18.8, 21.3], // 38 bulan
      [10.3, 11.6, 13.1, 14.8, 16.8, 19.0, 21.6], // 39 bulan
      [10.4, 11.8, 13.3, 15.0, 17.0, 19.3, 21.9], // 40 bulan
      [10.5, 11.9, 13.4, 15.2, 17.2, 19.5, 22.1], // 41 bulan
      [10.6, 12.0, 13.6, 15.3, 17.4, 19.7, 22.4], // 42 bulan
      [10.7, 12.1, 13.7, 15.5, 17.6, 20.0, 22.7], // 43 bulan
      [10.8, 12.2, 13.8, 15.7, 17.8, 20.2, 23.0], // 44 bulan
      [10.9, 12.4, 14.0, 15.8, 18.0, 20.5, 23.3], // 45 bulan
      [11.0, 12.5, 14.1, 16.0, 18.2, 20.7, 23.6], // 46 bulan
      [11.1, 12.6, 14.3, 16.2, 18.4, 20.9, 23.9], // 47 bulan
      [11.2, 12.7, 14.4, 16.3, 18.6, 21.2, 24.2], // 48 bulan
      [11.3, 12.8, 14.5, 16.5, 18.8, 21.4, 24.5], // 49 bulan
      [11.1, 12.6, 14.3, 16.4, 19.0, 22.1, 25.9], // 50 bulan
      [11.5, 13.1, 14.8, 16.8, 19.2, 21.9, 25.1], // 51 bulan
      [11.6, 13.2, 15.0, 17.0, 19.4, 22.2, 25.4], // 52 bulan
      [11.7, 13.3, 15.1, 17.2, 19.6, 22.4, 25.7], // 53 bulan
      [11.8, 13.4, 15.2, 17.3, 19.8, 22.7, 26.0], // 54 bulan
      [11.9, 13.5, 15.4, 17.5, 20.0, 22.9, 26.3], // 55 bulan
      [12.0, 13.6, 15.5, 17.7, 20.2, 23.2, 26.6], // 56 bulan
      [12.1, 13.7, 15.6, 17.8, 20.4, 23.4, 26.9], // 57 bulan
      [12.2, 13.8, 15.8, 18.0, 20.6, 23.7, 27.2], // 58 bulan
      [12.3, 14.0, 15.9, 18.2, 20.8, 23.9, 27.6], // 59 bulan
      [12.4, 14.1, 16.0, 18.3, 21.0, 24.2, 27.9], // 60 bulan
      // More data here...
    ];
  }

  List<List<double>> _getFemaleTable() {
    return [
      [2.0, 2.4, 2.8, 3.2, 3.7, 4.2, 4.8], // 0 bulan
      [2.7, 3.2, 3.6, 4.2, 4.8, 5.5, 6.2], // 1 bulan
      [3.4, 3.9, 4.5, 5.1, 5.8, 6.6, 7.5], // 2 bulan
      [4.0, 4.5, 5.2, 5.8, 6.6, 7.5, 8.5], // 3 bulan
      [4.4, 5.0, 5.7, 6.4, 7.3, 8.2, 9.3], // 4 bulan
      [4.8, 5.4, 6.1, 6.9, 7.8, 8.8, 10.0], // 5 bulan
      [5.1, 5.7, 6.5, 7.3, 8.2, 9.3, 10.6], // 6 bulan
      [5.3, 6.0, 6.8, 7.6, 8.6, 9.8, 11.1], // 7 bulan
      [5.6, 6.3, 7.0, 7.9, 9.0, 10.2, 11.6], // 8 bulan
      [5.8, 6.5, 7.3, 8.2, 9.3, 10.5, 12.0], // 9 bulan
      [5.9, 6.7, 7.5, 8.5, 9.6, 10.9, 12.4], // 10 bulan
      [6.1, 6.9, 7.7, 8.7, 9.9, 11.2, 12.8], // 11 bulan
      [6.3, 7.0, 7.9, 8.9, 10.1, 11.5, 13.1], // 12 bulan
      [6.4, 7.2, 8.1, 9.2, 10.4, 11.8, 13.5], // 13 bulan
      [6.6, 7.4, 8.3, 9.4, 10.6, 12.1, 13.8], // 14 bulan
      [6.7, 7.6, 8.5, 9.6, 10.9, 12.4, 14.1], // 15 bulan
      [6.9, 7.7, 8.7, 9.8, 11.1, 12.6, 14.5], // 16 bulan
      [7.0, 7.9, 8.9, 10.0, 11.4, 12.9, 14.8], // 17 bulan
      [7.2, 8.1, 9.1, 10.2, 11.6, 13.2, 15.1], // 18 bulan
      [7.3, 8.2, 9.2, 10.4, 11.8, 13.5, 15.4], // 19 bulan
      [7.5, 8.4, 9.4, 10.6, 12.1, 13.7, 15.7], // 20 bulan
      [7.6, 8.6, 9.6, 10.9, 12.3, 14.0, 16.0], // 21 bulan
      [7.8, 8.7, 9.8, 11.1, 12.5, 14.3, 16.4], // 22 bulan
      [7.9, 8.9, 10.0, 11.3, 12.8, 14.6, 16.7], // 23 bulan
      [8.1, 9.0, 10.2, 11.5, 13.0, 14.8, 17.0], // 24 bulan
      [8.2, 9.2, 10.3, 11.7, 13.3, 15.1, 17.3], // 25 bulan
      [8.4, 9.4, 10.5, 11.9, 13.5, 15.4, 17.7], // 26 bulan
      [8.5, 9.5, 10.7, 12.1, 13.7, 15.7, 18.0], // 27 bulan
      [8.6, 9.7, 10.9, 12.3, 14.0, 16.0, 18.3], // 28 bulan
      [8.8, 9.8, 11.1, 12.5, 14.2, 16.2, 18.7], // 29 bulan
      [8.9, 10.0, 11.2, 12.7, 14.4, 16.5, 19.0], // 30 bulan
      [9.0, 10.1, 11.4, 12.9, 14.7, 16.8, 19.3], // 31 bulan
      [9.1, 10.3, 11.6, 13.1, 14.9, 17.1, 19.6], // 32 bulan
      [9.3, 10.4, 11.7, 13.3, 15.1, 17.3, 20.0], // 33 bulan
      [9.4, 10.5, 11.9, 13.5, 15.4, 17.6, 20.3], // 34 bulan
      [9.5, 10.7, 12.0, 13.7, 15.6, 17.9, 20.6], // 35 bulan
      [9.6, 10.8, 12.2, 13.9, 15.8, 18.1, 20.9], // 36 bulan
      [9.7, 10.9, 12.4, 14.0, 16.0, 18.4, 21.3], // 37 bulan
      [9.8, 11.1, 12.5, 14.2, 16.3, 18.7, 21.6], // 38 bulan
      [9.9, 11.2, 12.7, 14.4, 16.5, 19.0, 22.0], // 39 bulan
      [10.1, 11.3, 12.8, 14.6, 16.7, 19.2, 22.3], // 40 bulan
      [10.2, 11.5, 13.0, 14.8, 16.9, 19.5, 22.7], // 41 bulan
      [10.3, 11.6, 13.1, 15.0, 17.2, 19.8, 23.0], // 42 bulan
      [10.4, 11.7, 13.3, 15.2, 17.4, 20.1, 23.4], // 43 bulan
      [10.5, 11.8, 13.4, 15.3, 17.6, 20.4, 23.7], // 44 bulan
      [10.6, 12.0, 13.6, 15.5, 17.8, 20.7, 24.1], // 45 bulan
      [10.7, 12.1, 13.7, 15.7, 18.1, 20.9, 24.5], // 46 bulan
      [10.8, 12.2, 13.9, 15.9, 18.3, 21.2, 24.8], // 47 bulan
      [10.9, 12.3, 14.0, 16.1, 18.5, 21.5, 25.2], // 48 bulan
      [11.0, 12.4, 14.2, 16.3, 18.8, 21.8, 25.5], // 49 bulan
      [11.1, 12.6, 14.3, 16.4, 19.0, 22.1, 25.9], // 50 bulan
      [11.2, 12.7, 14.5, 16.6, 19.2, 22.4, 26.3], // 51 bulan
      [11.3, 12.8, 14.6, 16.8, 19.4, 22.6, 26.6], // 52 bulan
      [11.4, 12.9, 14.8, 17.0, 19.7, 22.9, 27.0], // 53 bulan
      [11.5, 13.0, 14.9, 17.2, 19.9, 23.2, 27.4], // 54 bulan
      [11.6, 13.2, 15.1, 17.3, 20.1, 23.5, 27.7], // 55 bulan
      [11.7, 13.3, 15.2, 17.5, 20.3, 23.8, 28.1], // 56 bulan
      [11.8, 13.4, 15.3, 17.7, 20.6, 24.1, 28.5], //57 bulan
      [11.9, 13.5, 15.5, 17.9, 20.8, 24.4, 28.8], // 58 bulan
      [12.0, 13.6, 15.6, 18.0, 21.0, 24.6, 29.2], // 59 bulan
      [12.1, 13.7, 15.8, 18.2, 21.2, 24.9, 29.5], // 60 bulan
      //      // More data here...
    ];
  }

  String getKategoriGizi(bool gender, int umur, double beratBadan) {
    // Tabel data untuk berat badan menurut umur (dalam bulan)
    List<List<double>> tabelData = gender ? _getMaleTable() : _getFemaleTable();

    // Menghindari akses indeks di luar batas array
    if (umur < 0 || umur >= tabelData.length) {
      return 'Umur tidak valid';
    }

    // Mendapatkan data berat badan untuk umur tertentu
    List<double> beratBadanData = tabelData[umur];

    // Menentukan kategori gizi
    if (beratBadan < beratBadanData[0]) {
      return 'Berat badan sangat kurang';
    } else if (beratBadan < beratBadanData[1]) {
      return 'Berat badan kurang';
    } else if (beratBadan < beratBadanData[2]) {
      return 'Berat badan normal';
    } else if (beratBadan < beratBadanData[3]) {
      return 'Berat badan normal';
    } else if (beratBadan < beratBadanData[4]) {
      return 'Risiko Berat badan lebih';
    } else if (beratBadan < beratBadanData[5]) {
      return 'Risiko Berat badan lebih';
    } else if (beratBadan < beratBadanData[6]) {
      return 'Risiko Berat badan lebih';
    } else {
      return 'Berat badan Obesitas Berat';
    }
  }
}
