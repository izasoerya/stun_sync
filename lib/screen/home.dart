import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/components/atom/Background_body.dart';
import 'package:stun_sync/components/atom/Massage_Box_Bmi.dart';
import 'package:stun_sync/components/atom/Massage_box_Height.dart';
import 'package:stun_sync/components/atom/linear_gauge.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/value_container.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/top_of_bar.dart';
import 'package:stun_sync/service/user_profile_data.dart';
import 'package:stun_sync/components/atom/linear_gauge_height.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color(0xFF22577A),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopOfBar(),
            Background_body(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentContainer(
                      child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ref.watch(userProfile).name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Age: 30',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '7 days left',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'until next check',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  ContentContainer(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
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
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleContainer(
                          title: "Height",
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
                                  Spacer(),
                                  Column(
                                    children: [
                                      MessageBoxHeight(
                                        height: ref.watch(userProfile).height,
                                      ),
                                      LinearGaugeHeight(
                                        height: ref.watch(userProfile).height,
                                      )
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
                        TitleContainer(
                          title: "Weight",
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
                                  Spacer(),
                                  Column(
                                    children: [
                                      MessageBoxHeight(
                                        height: ref.watch(userProfile).weight,
                                      ),
                                      LinearGaugeHeight(
                                          height: ref.watch(userProfile).weight)
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
                        TitleContainer(
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
                                  Spacer(),
                                  Column(
                                    children: [
                                      MessageBoxBmi(
                                          height: ref.watch(userProfile).bmi),
                                      LinearGaugeHeight(
                                          height: ref.watch(userProfile).bmi),
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
                  Padding(padding: EdgeInsets.only(bottom: 30))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
