import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/components/atom/edit_value.dart';
import 'package:stun_sync/components/atom/unit_container.dart';
import 'package:stun_sync/service/user_profile_controller.dart';
import 'package:stun_sync/components/atom/Background_body.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/value_container.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/top_of_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFF22577A),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 15)),
            const TopOfBar(),
            Background_body(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  ContentContainer(
                      child: Container(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ref.watch(userProfile).name}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${ref.watch(userProfile).age.toString()} Tahun',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // const Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Text(
                        //       '7 days left',
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //     Text(
                        //       'until next check',
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  )),
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
                              'Ensure they receive a balanced diet rich in protein, calcium, vitamin D, and provide physical stimulation through exercise or activities that stimulate bone and muscle growth.'),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleContainer(
                          title: "Tinggi Badan",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ValueContainer(
                                      value:
                                          '${ref.watch(userProfile).height}'),
                                  Padding(padding: EdgeInsets.only(right: 5)),
                                  Column(
                                    children: [
                                      SizedBox(height: 15),
                                      UnitContainer(unit: 'cm'),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Column(
                                    children: [EditValue()],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleContainer(
                          title: "Berat Badan",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ValueContainer(
                                      value:
                                          '${ref.watch(userProfile).weight}'),
                                  Padding(padding: EdgeInsets.only(right: 5)),
                                  const Column(
                                    children: [
                                      SizedBox(height: 15),
                                      UnitContainer(unit: 'kg'),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Column(
                                    children: [
                                      // MessageBoxHeight(
                                      //   height: ref.watch(userProfile).weight,
                                      // ),
                                      // LinearGaugeHeight(
                                      //     height:
                                      //         ref.watch(userProfile).weight),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleContainer(
                          title: "BMI",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ValueContainer(
                                      value:
                                          '${ref.watch(userProfile).bmi.toStringAsFixed(2)}'),
                                  const Spacer(),
                                  const Column()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleContainer(
                          title: "Lingkar Dada",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ValueContainer(
                                      value:
                                          '${ref.watch(userProfile).lingkarDada}'),
                                  Padding(padding: EdgeInsets.only(right: 5)),
                                  const Column(
                                    children: [
                                      SizedBox(height: 15),
                                      UnitContainer(unit: 'cm'),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Column(
                                    children: [
                                      // MessageBoxHeight(
                                      //   height: ref.watch(userProfile).weight,
                                      // ),
                                      // LinearGaugeHeight(
                                      //     height:
                                      //         ref.watch(userProfile).weight),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleContainer(
                          title: "lingkar kepala",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ValueContainer(
                                      value:
                                          '${ref.watch(userProfile).lingkarKepala}'),
                                  Padding(padding: EdgeInsets.only(right: 5)),
                                  const Column(
                                    children: [
                                      SizedBox(height: 15),
                                      UnitContainer(unit: 'cm'),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Column(
                                    children: [
                                      // MessageBoxHeight(
                                      //   height: ref.watch(userProfile).weight,
                                      // ),
                                      // LinearGaugeHeight(
                                      //     height:
                                      //         ref.watch(userProfile).weight),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
