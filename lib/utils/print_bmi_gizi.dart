import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class BMIBulan extends ConsumerWidget {
  const BMIBulan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Contoh input umur dan tinggi badan
    int umur = ref.watch(userProfileProvider).age; // contoh umur dalam bulan
    double tinggiBadan =
        ref.watch(userProfileProvider).bmi; // contoh tinggi badan dalam cm
    bool gender = ref.watch(userProfileProvider).isMale;

    // Memanggil fungsi getKategoriGizi
    String kategoriGizi = getKategoriGizi(gender, umur, tinggiBadan);

    // Menggunakan MediaQuery untuk mendapatkan lebar layar
    double screenWidth = MediaQuery.of(context).size.width;

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
      case 'Gizi buruk':
        return Colors.red;
      case 'Gizi kurang':
        return Colors.orange;
      case 'Gizi normal':
        return Colors.green;
      case 'Beresiko Gizi lebih':
        return Colors.orange;
      case 'Gizi lebih':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  List<List<double>> _getMaleTable() {
    return [
      [10.2, 11.1, 12.2, 13.4, 14.8, 16.3, 18.1], // 0 bulan
      [11.3, 12.4, 13.4, 14.8, 16.3, 17.8, 19.6], // 1 bulan
      [12.5, 13.7, 14.7, 16.0, 17.6, 19.2, 21.0], // 2 bulan
      [13.1, 14.3, 15.5, 16.8, 18.4, 20.0, 21.9], // 3 bulan
      [13.4, 14.5, 15.8, 17.2, 18.8, 20.5, 22.3], // 4 bulan
      [13.5, 14.7, 15.9, 17.3, 18.8, 20.5, 22.3], // 5 bulan
      [13.6, 14.7, 16.0, 17.3, 18.8, 20.5, 22.3], // 6 bulan
      [13.7, 14.8, 16.0, 17.3, 18.8, 20.5, 22.3], // 7 bulan
      [13.6, 14.7, 15.9, 17.2, 18.7, 20.3, 22.1], // 8 bulan
      [13.4, 14.5, 15.7, 17.0, 18.5, 20.1, 21.8], // 9 bulan
      [13.5, 14.6, 15.8, 17.1, 18.6, 20.1, 21.8], // 10 bulan
      [13.4, 14.6, 15.8, 17.0, 18.5, 20.0, 21.6], // 11 bulan
      [13.4, 14.7, 15.8, 17.1, 18.6, 20.1, 21.7], // 12 bulan
      [13.3, 14.6, 15.7, 16.9, 18.4, 19.9, 21.5], // 13 bulan
      [13.2, 14.5, 15.6, 16.8, 18.3, 19.8, 21.4], // 14 bulan
      [13.1, 14.4, 15.5, 16.6, 18.1, 19.6, 21.2], // 15 bulan
      [13.1, 14.4, 15.5, 16.6, 18.1, 19.6, 21.2], // 16 bulan
      [13.0, 14.3, 15.5, 16.5, 18.0, 19.5, 21.1], // 17 bulan
      [12.9, 14.2, 15.4, 16.4, 17.9, 19.3, 20.9], // 18 bulan
      [12.9, 14.2, 15.4, 16.4, 17.9, 19.3, 20.9], // 19 bulan
      [12.8, 14.1, 15.3, 16.3, 17.8, 19.2, 20.8], // 20 bulan
      [12.8, 14.1, 15.3, 16.3, 17.8, 19.2, 20.8], // 21 bulan
      [12.7, 14.0, 15.2, 16.2, 17.7, 19.0, 20.6], // 22 bulan
      [12.7, 14.0, 15.2, 16.2, 17.7, 19.0, 20.6], // 23 bulan
      [12.7, 14.0, 15.2, 16.2, 17.7, 19.0, 20.6], // 24 bulan

      [12.8, 13.8, 14.8, 16.0, 17.3, 18.8, 20.5], // 25 bulan
      [12.8, 13.7, 14.7, 15.9, 17.3, 18.7, 20.4], // 26 bulan
      [12.7, 13.7, 14.7, 15.9, 17.2, 18.7, 20.4], // 27 bulan
      [12.7, 13.6, 14.6, 15.8, 17.1, 18.6, 20.3], // 28 bulan
      [12.7, 13.6, 14.6, 15.8, 17.1, 18.6, 20.3], // 29 bulan
      [12.6, 13.6, 14.6, 15.8, 17.1, 18.6, 20.2], // 30 bulan
      [12.6, 13.5, 14.5, 15.8, 17.0, 18.5, 20.2], // 31 bulan
      [12.5, 13.5, 14.5, 15.7, 17.0, 18.5, 20.1], // 32 bulan
      [12.5, 13.5, 14.5, 15.7, 17.0, 18.5, 20.1], // 33 bulan
      [12.5, 13.4, 14.5, 15.7, 17.0, 18.4, 20.0], // 34 bulan
      [12.4, 13.4, 14.5, 15.7, 17.0, 18.4, 20.0], // 35 bulan
      [12.4, 13.4, 14.5, 15.7, 16.9, 18.4, 20.0], // 36 bulan
      [12.4, 13.3, 14.4, 15.6, 16.9, 18.3, 19.9], // 37 bulan
      [12.3, 13.3, 14.4, 15.6, 16.9, 18.3, 19.9], // 38 bulan
      [12.3, 13.3, 14.4, 15.6, 16.9, 18.3, 19.9], // 39 bulan
      [12.3, 13.3, 14.4, 15.6, 16.9, 18.3, 19.9], // 40 bulan
      [12.2, 13.2, 14.4, 15.6, 16.9, 18.3, 19.8], // 41 bulan
      [12.2, 13.2, 14.3, 15.5, 16.8, 18.2, 19.8], // 42 bulan
      [12.2, 13.2, 14.3, 15.5, 16.8, 18.2, 19.8], // 43 bulan
      [12.2, 13.2, 14.3, 15.5, 16.8, 18.2, 19.8], // 44 bulan
      [12.1, 13.1, 14.2, 15.4, 16.7, 18.1, 19.7], // 45 bulan
      [12.1, 13.1, 14.2, 15.4, 16.7, 18.1, 19.7], // 46 bulan
      [12.1, 13.1, 14.2, 15.4, 16.7, 18.1, 19.7], // 47 bulan
      [12.1, 13.1, 14.2, 15.4, 16.7, 18.1, 19.7], // 48 bulan
      [12.1, 13.1, 14.2, 15.4, 16.7, 18.1, 19.7], // 49 bulan
      [12.1, 13.1, 14.2, 15.4, 16.7, 18.1, 19.7], // 50 bulan
      [12.2, 13.2, 14.3, 15.5, 16.8, 18.2, 19.8], // 51 bulan
      [12.2, 13.2, 14.3, 15.5, 16.8, 18.2, 19.8], // 52 bulan
      [12.1, 13.2, 14.3, 15.5, 16.8, 18.2, 19.8], // 53 bulan
      [12.0, 13.0, 14.0, 15.3, 16.6, 18.2, 20.0], // 54 bulan
      [12.0, 13.0, 14.0, 15.2, 16.6, 18.2, 20.0], // 55 bulan
      [12.0, 12.9, 14.0, 15.2, 16.6, 18.2, 20.1], // 56 bulan
      [12.0, 12.9, 14.0, 15.2, 16.6, 18.2, 20.1], // 57 bulan
      [12.0, 12.9, 14.0, 15.2, 16.6, 18.2, 20.1], // 58 bulan
      [12.0, 12.9, 14.0, 15.2, 16.6, 18.2, 20.1], // 59 bulan
      [12.0, 12.9, 14.0, 15.2, 16.6, 18.3, 20.3], // 60 bulan
    ];
  }

  List<List<double>> _getFemaleTable() {
    return [
      [10.1, 11.2, 12.2, 13.3, 14.6, 16.1, 17.7], // 0 months
      [10.8, 12.0, 13.0, 14.1, 15.4, 17.0, 18.7], // 1 month
      [10.8, 12.1, 13.2, 14.4, 15.8, 17.5, 20.7], // 2 months
      [12.4, 13.9, 15.0, 16.1, 17.4, 19.0, 20.7], // 3 months
      [12.7, 14.2, 15.3, 16.4, 17.7, 19.3, 20.9], // 4 months
      [12.9, 14.4, 15.4, 16.8, 18.4, 20.0, 22.2], // 5 months
      [13.0, 14.5, 15.6, 17.1, 18.7, 20.3, 22.3], // 6 months
      [13.1, 14.6, 15.7, 17.2, 18.8, 20.3, 22.3], // 7 months
      [13.1, 14.7, 15.8, 17.3, 18.9, 20.4, 22.3], // 8 months
      [13.2, 14.8, 15.9, 17.4, 19.0, 20.4, 22.3], // 9 months
      [13.2, 14.8, 15.9, 17.5, 19.0, 20.4, 22.3], // 10 months
      [13.3, 14.9, 16.0, 17.6, 19.1, 20.5, 22.4], // 11 months
      [13.3, 14.9, 16.0, 17.6, 19.1, 20.5, 22.4], // 12 months
      [12.7, 13.9, 15.0, 16.4, 17.7, 19.3, 20.9], // 13 months
      [12.8, 14.0, 15.1, 16.5, 17.8, 19.4, 21.0], // 14 months
      [12.8, 14.1, 15.2, 16.6, 17.9, 19.5, 21.0], // 15 months
      [12.8, 14.2, 15.3, 16.7, 18.0, 19.5, 21.1], // 16 months
      [12.8, 14.3, 15.4, 16.7, 18.0, 19.5, 21.3], // 17 months
      [12.3, 13.4, 14.4, 15.7, 17.1, 18.8, 20.8], // 18 months
      [12.2, 13.2, 14.3, 15.6, 17.0, 18.7, 20.6], // 19 months
      [12.2, 13.2, 14.3, 15.5, 17.0, 18.6, 20.5], // 20 months
      [12.2, 13.1, 14.2, 15.5, 16.9, 18.5, 20.4], // 21 months
      [12.2, 13.1, 14.2, 15.4, 16.9, 18.5, 20.4], // 22 months
      [12.1, 13.1, 14.2, 15.4, 16.8, 18.4, 20.3], // 23 months
      [12.4, 13.3, 14.4, 15.7, 17.1, 18.7, 20.6],
      [12.4, 13.3, 14.4, 15.7, 17.1, 18.7, 20.6],
      [12.3, 13.3, 14.4, 15.6, 17.0, 18.6, 20.4],
      [12.3, 13.4, 14.4, 15.6, 17.0, 18.7, 20.4],
      [12.3, 13.4, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.3, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.3, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.3, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.2, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.2, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.2, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.2, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.2, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.1, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.1, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.1, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.1, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.1, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [12.1, 13.5, 14.5, 15.6, 17.0, 18.7, 20.4],
      [11.9, 13.3, 14.4, 15.6, 17.1, 18.8, 20.6],
      [11.9, 12.9, 14.0, 15.3, 16.8, 18.5, 20.4],
      [11.8, 12.9, 14.0, 15.3, 16.8, 18.5, 20.5],
      [11.8, 12.9, 14.0, 15.3, 16.8, 18.5, 20.5],
      [11.8, 12.9, 14.0, 15.3, 16.8, 18.5, 20.5],
      [11.8, 12.9, 14.0, 15.3, 16.8, 18.5, 20.5],
      [11.8, 12.9, 14.0, 15.3, 16.8, 18.5, 20.5],
      [11.8, 12.9, 14.0, 15.3, 16.8, 18.5, 20.5],
      [11.8, 12.9, 14.0, 15.3, 16.8, 18.5, 20.6],
      [11.7, 12.8, 13.9, 15.3, 16.8, 18.5, 20.7],
      [11.7, 12.8, 13.9, 15.3, 16.8, 18.5, 20.7],
      [11.7, 12.8, 13.9, 15.3, 16.8, 18.5, 20.8],
      [11.7, 12.8, 13.9, 15.3, 16.8, 18.5, 20.9],
      [11.7, 12.8, 13.9, 15.3, 16.8, 18.5, 20.9],
      [11.7, 12.8, 13.9, 15.3, 16.8, 18.5, 20.9],
      [11.6, 12.8, 13.9, 15.3, 16.8, 18.5, 20.9],
      [11.6, 12.7, 13.9, 15.3, 16.9, 18.6, 21.0],
      [11.6, 12.7, 13.9, 15.3, 16.9, 18.6, 21.1],
    ];
  }

  String getKategoriGizi(bool gender, int umur, double tinggiBadan) {
    // Tabel data untuk berat badan menurut umur (dalam bulan)
    List<List<double>> tabelData = gender ? _getMaleTable() : _getFemaleTable();

    // Menghindari akses indeks di luar batas array
    if (umur < 0 || umur >= tabelData.length) {
      return 'Umur tidak valid';
    }

    // Mendapatkan data tinggi badan untuk umur tertentu
    List<double> tinggiBadanData = tabelData[umur];

    // Menentukan kategori gizi
    if (tinggiBadan < tinggiBadanData[0]) {
      return 'Gizi buruk';
    } else if (tinggiBadan < tinggiBadanData[1]) {
      return 'Gizi kurang';
    } else if (tinggiBadan < tinggiBadanData[2]) {
      return 'Gizi normal';
    } else if (tinggiBadan < tinggiBadanData[3]) {
      return 'Gizi normal';
    } else if (tinggiBadan < tinggiBadanData[4]) {
      return 'Gizi normal';
    } else if (tinggiBadan < tinggiBadanData[5]) {
      return 'Beresiko Gizi lebih';
    } else if (tinggiBadan < tinggiBadanData[6]) {
      return 'Gizi lebih';
    } else {
      return 'Obesitas';
    }
  }
}
