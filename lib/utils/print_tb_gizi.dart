import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class Tbbulan extends ConsumerWidget {
  const Tbbulan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Contoh input umur dan tinggi badan
    int umur = ref.watch(userProfileProvider).age; // contoh umur dalam bulan
    double tinggiBadan =
        ref.watch(userProfileProvider).height; // contoh tinggi badan dalam cm

    // Memanggil fungsi getKategoriGizi
    String kategoriGizi = getKategoriGizi(umur, tinggiBadan);

    // Menggunakan MediaQuery untuk mendapatkan lebar layar
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth *
                  0.45, // Adjusting the width to 80% of screen width
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
      case 'Tinggi badan sangat pendek':
        return Colors.red;
      case 'Tinggi badan pendek':
        return Colors.orange;
      case 'Tinggi badan normal':
        return Colors.green;
      case 'Tinggi badan tinggi':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  String getKategoriGizi(int umur, double tinggiBadan) {
    // Tabel data untuk tinggi badan menurut umur (dalam bulan)
    List<List<double>> tabelData = [
      [44.2, 46.1, 48.0, 49.9, 51.8, 53.7, 55.6], // 0 bulan
      [48.9, 50.8, 52.8, 54.7, 56.7, 58.6, 60.6], // 1 bulan
      [52.4, 54.4, 56.4, 58.4, 60.4, 62.4, 64.4], // 2 bulan
      [55.3, 57.3, 59.4, 61.4, 63.5, 65.5, 67.6], // 3 bulan
      [57.6, 59.7, 61.8, 63.9, 66.0, 68.0, 70.1], // 4 bulan
      [59.6, 61.7, 63.8, 65.9, 68.0, 70.1, 72.2], // 5 bulan
      [61.2, 63.3, 65.5, 67.6, 69.8, 71.9, 74.0], // 6 bulan
      [62.7, 64.8, 67.0, 69.2, 71.3, 73.5, 75.7], // 7 bulan
      [64.0, 66.2, 68.4, 70.6, 72.8, 75.0, 77.2], // 8 bulan
      [65.2, 67.5, 69.7, 72.0, 74.2, 76.5, 78.7], // 9 bulan
      [66.4, 68.7, 71.0, 73.3, 75.6, 77.9, 80.1], // 10 bulan
      [67.6, 69.9, 72.2, 74.5, 76.9, 79.2, 81.5], // 11 bulan
      [68.6, 71.0, 73.4, 75.7, 78.1, 80.5, 82.9], // 12 bulan
      [69.6, 72.1, 74.5, 76.9, 79.3, 81.8, 84.2], // 13 bulan
      [70.6, 73.1, 75.6, 78.0, 80.5, 83.0, 85.5], // 14 bulan
      [71.6, 74.1, 76.6, 79.1, 81.7, 84.2, 86.7], // 15 bulan
      [72.5, 75.0, 77.6, 80.2, 82.8, 85.4, 88.0], // 16 bulan
      [73.3, 76.0, 78.6, 81.2, 83.9, 86.5, 89.2], // 17 bulan
      [74.2, 76.9, 79.6, 82.3, 85.0, 87.7, 90.4], // 18 bulan
      [75.0, 77.7, 80.5, 83.2, 86.0, 88.8, 91.5], // 19 bulan
      [75.8, 78.6, 81.4, 84.2, 87.0, 89.8, 92.6], // 20 bulan
      [76.5, 79.4, 82.3, 85.1, 88.0, 90.9, 93.8], // 21 bulan
      [77.2, 80.2, 83.1, 86.0, 89.0, 91.9, 94.9], // 22 bulan
      [78.0, 81.0, 83.9, 86.9, 89.9, 92.9, 95.9], // 23 bulan
      [78.7, 81.7, 84.8, 87.8, 90.9, 93.9, 97.0], // 24 bulan
      [78.0, 81.0, 84.1, 87.1, 90.2, 93.2, 96.3], // 25 bulan
      [78.6, 81.7, 84.9, 88.0, 91.1, 94.2, 97.3], // 26 bulan
      [79.3, 82.5, 85.6, 88.8, 92.0, 95.2, 98.3], // 27 bulan
      [79.9, 83.1, 86.4, 89.6, 92.9, 96.1, 99.3], // 28 bulan
      [80.5, 83.8, 87.1, 90.4, 93.7, 97.0, 100.3], // 29 bulan
      [81.1, 84.5, 87.8, 91.2, 94.5, 97.9, 101.2], // 30 bulan
      [81.7, 85.1, 88.5, 91.9, 95.3, 98.7, 102.1], // 31 bulan
      [82.3, 85.7, 89.2, 92.7, 96.1, 99.6, 103.0], // 32 bulan
      [82.8, 86.4, 89.9, 93.4, 96.9, 100.4, 103.9], // 33 bulan
      [83.4, 86.9, 90.5, 94.1, 97.6, 101.2, 104.8], // 34 bulan
      [83.9, 87.5, 91.1, 94.8, 98.4, 102.0, 105.6], // 35 bulan
      [84.4, 88.1, 91.8, 95.4, 99.1, 102.7, 106.4], // 36 bulan
      [85.0, 88.7, 92.4, 96.1, 99.8, 103.5, 107.2], // 37 bulan
      [85.5, 89.2, 93.0, 96.7, 100.5, 104.2, 108.0], // 38 bulan
      [86.0, 89.8, 93.6, 97.4, 101.2, 105.0, 108.8], // 39 bulan
      [86.5, 90.3, 94.2, 98.0, 101.8, 105.7, 109.5], // 40 bulan
      [87.0, 90.9, 94.7, 98.6, 102.5, 106.4, 110.3], // 41 bulan
      [87.5, 91.4, 95.3, 99.2, 103.2, 107.1, 111.0], // 42 bulan
      [88.0, 91.9, 95.9, 99.9, 103.8, 107.8, 111.7], // 43 bulan
      [88.4, 92.4, 96.4, 100.4, 104.5, 108.5, 112.5], // 44 bulan
      [88.9, 93.0, 97.0, 101.0, 105.1, 109.1, 113.2], // 45 bulan
      [89.4, 93.5, 97.5, 101.6, 105.7, 109.8, 113.9], // 46 bulan
      [89.8, 94.0, 98.1, 102.2, 106.3, 110.4, 114.6], // 47 bulan
      [90.3, 94.4, 98.6, 102.8, 106.9, 111.1, 115.2], // 48 bulan
      [90.7, 94.9, 99.1, 103.3, 107.5, 111.7, 115.9], // 49 bulan
      [91.2, 95.4, 99.7, 103.9, 108.1, 112.4, 116.6], // 50 bulan
      [91.6, 95.9, 100.2, 104.4, 108.7, 113.0, 117.3], // 51 bulan
      [92.1, 96.4, 100.7, 105.0, 109.3, 113.6, 117.9], // 52 bulan
      [92.5, 96.9, 101.2, 105.6, 109.9, 114.2, 118.6], // 53 bulan
      [93.0, 97.4, 101.7, 106.1, 110.5, 114.9, 119.2], // 54 bulan
      [93.4, 97.8, 102.3, 106.7, 111.1, 115.5, 119.9], // 55 bulan
      [93.9, 98.3, 102.8, 107.2, 111.7, 116.1, 120.6], // 56 bulan
      [94.3, 98.8, 103.3, 107.8, 112.3, 116.7, 121.2], // 57 bulan
      [94.7, 99.3, 103.8, 108.3, 112.8, 117.4, 121.9], // 58 bulan
      [95.2, 99.7, 104.3, 108.9, 113.4, 118.0, 122.6], // 59 bulan
      [95.6, 100.2, 104.8, 109.4, 114.0, 118.6, 123.2], // 60 bulan
    ];

    // Menghindari akses indeks di luar batas array
    if (umur < 0 || umur >= tabelData.length) {
      return 'Umur tidak valid';
    }

    // Mendapatkan data tinggi badan untuk umur tertentu
    List<double> tinggiBadanData = tabelData[umur];

    // Menentukan kategori gizi
    if (tinggiBadan < tinggiBadanData[0]) {
      return 'Tinggi badan sangat pendek';
    } else if (tinggiBadan < tinggiBadanData[1]) {
      return 'Tinggi badan pendek';
    } else if (tinggiBadan < tinggiBadanData[2]) {
      return 'Tinggi badan normal';
    } else if (tinggiBadan < tinggiBadanData[3]) {
      return 'Tinggi badan normal';
    } else if (tinggiBadan < tinggiBadanData[4]) {
      return 'Tinggi badan normal';
    } else if (tinggiBadan < tinggiBadanData[5]) {
      return 'Tinggi badan tinggi';
    } else if (tinggiBadan < tinggiBadanData[6]) {
      return 'Tinggi badan tinggi';
    } else {
      return 'Tinggi badan sangat tinggi';
    }
  }
}
