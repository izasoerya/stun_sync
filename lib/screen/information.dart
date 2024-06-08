import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/components/atom/Background_body.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/top_of_bar.dart';
import 'package:stun_sync/components/atom/tb_text.dart';

class InformationPage extends ConsumerWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFF22577A),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopOfBar(),
              Background_body(
                  child: Column(
                children: [
                  ContentContainer(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleContainer(
                            title: "Recomendation",
                          ),
                          Text(
                              'Ensure they receive a balanced diet rich in protein, calcium, vitamin D,'
                              'and provide physical stimulation through exercise or activities that stimulate bone and muscle growth.'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ContentContainer(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleContainer(
                            title: "Tinggi Badan",
                          ),
                          Text(
                              'Pertumbuhan tinggi badan anak adalah indikator penting dalam memantau kesehatan dan perkembangan mereka. '
                              'Anak-anak mengalami fase pertumbuhan yang signifikan sejak lahir hingga usia dewasa muda. '
                              'Proses ini dipengaruhi oleh berbagai faktor seperti genetik, nutrisi, lingkungan, dan kesehatan secara keseluruhan.'),
                          TextButton(
                              onPressed: () {
                                TB_Text(context);
                              },
                              child: const Text(
                                'Baca Selengkapnya.......',
                                style: TextStyle(
                                  color: Color(0xFF22577A),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ContentContainer(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleContainer(
                            title: "Berat Badan",
                          ),
                          Text(
                              'Ensure they receive a balanced diet rich in protein, calcium, vitamin D,'
                              'and provide physical stimulation through exercise or activities that stimulate bone and muscle growth.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}
