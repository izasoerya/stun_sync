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
        ref.watch(userProfileProvider).height; // contoh tinggi badan dalam cm
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
      case 'Tinggi badan normal':
        return Colors.green;
      case 'Tinggi badan tinggi':
        return Colors.blue;
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
      [12.9, 13.8, 14.8, 16.0, 17.3, 18.8, 20.6], // 24 bulan
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
      [43.6, 45.4, 47.3, 49.1, 51.0, 52.9, 54.7], // 0 months
      [47.8, 49.8, 51.7, 53.7, 55.6, 57.6, 59.5], // 1 month
      [51.0, 53.0, 55.0, 57.1, 59.1, 61.1, 63.2], // 2 months
      [53.5, 55.6, 57.7, 59.8, 61.9, 64.0, 66.1], // 3 months
      [55.6, 57.8, 59.9, 62.1, 64.3, 66.4, 68.6], // 4 months
      [57.4, 59.6, 61.8, 64.0, 66.2, 68.5, 70.7], // 5 months
      [58.9, 61.2, 63.5, 65.7, 68.0, 70.3, 72.5], // 6 months
      [60.3, 62.7, 65.0, 67.3, 69.6, 71.9, 74.2], // 7 months
      [61.7, 64.0, 66.4, 68.7, 71.1, 73.5, 75.8], // 8 months
      [62.9, 65.3, 67.7, 70.1, 72.6, 75.0, 77.4], // 9 months
      [64.1, 66.5, 69.0, 71.5, 73.9, 76.4, 78.9], // 10 months
      [65.2, 67.7, 70.3, 72.8, 75.3, 77.8, 80.3], // 11 months
      [66.3, 68.9, 71.4, 74.0, 76.6, 79.2, 81.7], // 12 months
      [67.3, 70.0, 72.6, 75.2, 77.8, 80.5, 83.1], // 13 months
      [68.3, 71.0, 73.7, 76.4, 79.1, 81.7, 84.4], // 14 months
      [69.3, 72.0, 74.8, 77.5, 80.2, 83.0, 85.7], // 15 months
      [70.2, 73.0, 75.8, 78.6, 81.4, 84.2, 87.0], // 16 months
      [71.1, 74.0, 76.8, 79.7, 82.5, 85.4, 88.2], // 17 months
      [72.0, 74.9, 77.8, 80.7, 83.6, 86.5, 89.4], // 18 months
      [72.8, 75.8, 78.8, 81.7, 84.7, 87.6, 90.6], // 19 months
      [73.7, 76.7, 79.7, 82.7, 85.7, 88.7, 91.7], // 20 months
      [74.5, 77.5, 80.6, 83.7, 86.7, 89.8, 92.9], // 21 months
      [75.2, 78.4, 81.5, 84.6, 87.7, 90.8, 94.0], // 22 months
      [76.0, 79.2, 82.3, 85.5, 88.7, 91.9, 95.0], // 23 months
      [76.7, 80.0, 83.2, 86.4, 89.6, 92.9, 96.1], // 24 months
      [76.8, 80.0, 83.3, 86.6, 89.9, 93.1, 96.4], // 25 months
      [77.5, 80.8, 84.1, 87.4, 90.8, 94.1, 97.4], // 26 months
      [78.1, 81.5, 84.9, 88.3, 91.7, 95.0, 98.4], // 27 months
      [78.8, 82.2, 85.7, 89.1, 92.5, 96.0, 99.4], // 28 months
      [79.5, 82.9, 86.4, 89.9, 93.4, 96.9, 100.3], // 29 months
      [80.1, 83.6, 87.1, 90.7, 94.2, 97.7, 101.3], // 30 months
      [80.7, 84.3, 87.9, 91.4, 95.0, 98.6, 102.2], // 31 months
      [81.3, 84.9, 88.6, 92.2, 95.8, 99.4, 103.1], // 32 months
      [81.9, 85.6, 89.3, 92.9, 96.6, 100.3, 103.9], // 33 months
      [82.5, 86.2, 89.9, 93.6, 97.4, 101.1, 104.8], // 34 months
      [83.1, 86.8, 90.6, 94.4, 98.1, 101.9, 105.6], // 35 months
      [83.6, 87.4, 91.2, 95.1, 98.9, 102.7, 106.5], // 36 months
      [84.2, 88.0, 91.9, 95.7, 99.6, 103.4, 107.3], // 37 months
      [84.7, 88.6, 92.5, 96.4, 100.3, 104.2, 108.1], // 38 months
      [85.3, 89.2, 93.1, 97.1, 101.0, 105.0, 108.9], // 39 months
      [85.8, 89.8, 93.8, 97.7, 101.7, 105.7, 109.7], // 40 months
      [86.3, 90.4, 94.4, 98.4, 102.4, 106.4, 110.5], // 41 months
      [86.8, 90.9, 95.0, 99.0, 103.1, 107.2, 111.2], // 42 months
      [87.4, 91.5, 95.6, 99.7, 103.8, 107.9, 112.0], // 43 months
      [87.9, 92.0, 96.2, 100.3, 104.5, 108.6, 112.7], // 44 months
      [88.4, 92.5, 96.7, 100.9, 105.1, 109.3, 113.5], // 45 months
      [88.9, 93.1, 97.3, 101.5, 105.8, 110.0, 114.2], // 46 months
      [89.3, 93.6, 97.9, 102.1, 106.4, 110.7, 114.9], // 47 months
      [89.8, 94.1, 98.4, 102.7, 107.0, 111.3, 115.7], // 48 months
      [90.3, 94.6, 99.0, 103.3, 107.7, 112.0, 116.4], // 49 months
      [90.7, 95.1, 99.5, 103.9, 108.3, 112.7, 117.1], // 50 months
      [91.2, 95.6, 100.1, 104.5, 108.9, 113.3, 117.7], // 51 months
      [91.7, 96.1, 100.6, 105.0, 109.5, 114.0, 118.4], // 52 months
      [92.1, 96.6, 101.1, 105.6, 110.1, 114.6, 119.1], // 53 months
      [92.6, 97.1, 101.6, 106.2, 110.7, 115.2, 119.8], // 54 months
      [93.0, 97.6, 102.2, 106.7, 111.3, 115.9, 120.4], // 55 months
      [93.4, 98.1, 102.7, 107.3, 111.9, 116.5, 121.1], // 56 months
      [93.9, 98.5, 103.2, 107.8, 112.5, 117.1, 121.8], // 57
      [94.3, 99.0, 103.7, 108.4, 113.0, 117.7, 122.4], //58
      [94.7, 99.5, 104.2, 108.9, 113.6, 118.3, 123.1], //59
      [95.2, 99.9, 104.7, 109.4, 114.2, 118.9, 123.7], //60
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
