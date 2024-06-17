import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class BMIutil extends ConsumerWidget {
  const BMIutil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Contoh input umur dan berat bada
    double screenWidth = MediaQuery.of(context).size.width;

    // Memanggil fungsi getKategoriGizi
    final double bmi = ref.watch(userProfileProvider).bmi;
    final String kategori = getKategoriBMI(bmi);
    final Color color = getKategoriColor(kategori);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth *
                  0.42, // Adjusting the width to 80% of screen width
              padding: EdgeInsets.all(16.0),

              child: Column(
                children: [
                  Text(
                    ' $kategori',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: getKategoriColor(kategori)),
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
        return Colors.blue;
      case 'Berat badan Obesitas Berat':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  String getKategoriBMI(double bmi) {
    if (bmi < 16) {
      return 'Berat badan sangat kurang';
    } else if (bmi < 18.5) {
      return 'Berat badan kurang';
    } else if (bmi < 25) {
      return 'Berat badan normal';
    } else if (bmi < 30) {
      return 'Risiko Berat badan lebih';
    } else {
      return 'Berat badan Obesitas Berat';
    }
  }
}
