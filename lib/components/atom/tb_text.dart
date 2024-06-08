import 'package:flutter/material.dart';

void TB_Text(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Tinggi Badan Anak'),
        content: const SingleChildScrollView(
          child: Text(
              'Pertumbuhan tinggi badan anak adalah indikator penting dalam memantau kesehatan dan perkembangan mereka. '
              'Anak-anak mengalami fase pertumbuhan yang signifikan sejak lahir hingga usia dewasa muda. '
              'Proses ini dipengaruhi oleh berbagai faktor seperti genetik, nutrisi, lingkungan, dan kesehatan secara keseluruhan. '
              'Memahami rentang tinggi badan ideal sesuai usia dapat membantu orang tua dan tenaga medis mengidentifikasi dan menangani potensi masalah pertumbuhan lebih awal.\n\n'
              'Berikut ini adalah rentang tinggi badan ideal untuk anak-anak dari usia 0 hingga 20 tahun dalam sentimeter (cm):\n\n'
              'Usia 0-1 Tahun\n'
              '- Lahir: 46-56 cm\n'
              '- 1 Bulan: 51-61 cm\n'
              '- 3 Bulan: 56-66 cm\n'
              '- 6 Bulan: 61-71 cm\n'
              '- 9 Bulan: 66-76 cm\n'
              '- 12 Bulan: 71-81 cm\n\n'
              'Usia 1-5 Tahun\n'
              '- 2 Tahun: 82-92 cm\n'
              '- 3 Tahun: 88-98 cm\n'
              '- 4 Tahun: 95-105 cm\n'
              '- 5 Tahun: 101-111 cm\n\n'
              'Usia 6-12 Tahun\n'
              '- 6 Tahun: 106-116 cm\n'
              '- 7 Tahun: 112-122 cm\n'
              '- 8 Tahun: 117-127 cm\n'
              '- 9 Tahun: 123-133 cm\n'
              '- 10 Tahun: 128-138 cm\n'
              '- 11 Tahun: 134-144 cm\n'
              '- 12 Tahun: 140-150 cm\n\n'
              'Usia 13-20 Tahun\n'
              '- 13 Tahun: 145-155 cm\n'
              '- 14 Tahun: 151-161 cm\n'
              '- 15 Tahun: 157-167 cm\n'
              '- 16 Tahun: 162-172 cm\n'
              '- 17 Tahun: 166-176 cm\n'
              '- 18 Tahun: 169-179 cm\n'
              '- 19 Tahun: 170-180 cm\n'
              '- 20 Tahun: 171-181 cm\n\n'
              'Memantau tinggi badan anak secara rutin dan membandingkannya dengan rentang ideal sesuai usia adalah langkah penting dalam memastikan anak tumbuh dengan sehat. '
              'Jika ada kekhawatiran mengenai pertumbuhan anak, konsultasikan dengan dokter atau ahli gizi untuk mendapatkan saran dan penanganan yang tepat. '
              'Faktor nutrisi, aktivitas fisik, dan gaya hidup sehat juga berperan penting dalam mendukung pertumbuhan anak secara optimal.'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Tutup',
              style: TextStyle(
                color: Color(0xFF22577A),
              ),
            ),
          ),
        ],
      );
    },
  );
}
