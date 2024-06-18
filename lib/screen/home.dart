import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/components/atom/edit_value.dart';
import 'package:stun_sync/components/atom/edit_value_lk.dart';
import 'package:stun_sync/components/atom/get_data_frommqtt.dart';
import 'package:stun_sync/components/atom/unit_container.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';
import 'package:stun_sync/components/atom/Background_body.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/value_container.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/top_of_bar.dart';
import 'package:stun_sync/utils/bmi.dart';
import 'package:stun_sync/utils/print_bb_gizi.dart';
import 'package:stun_sync/utils/print_tb_gizi.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? _timer;
  void _updateState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _updateDataUser(); // This will call _updateDataUser every 5 seconds
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Step 4
    super.dispose();
  }

  void _updateDataUser() async {
    UserProfile? user = await const SQLiteDB().getUserByNameAndPassword(
        ref.watch(userProfileProvider).name,
        ref.watch(userProfileProvider).password);
    ref.read(userProfileProvider.notifier).setUser(user!);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime dateOfBirth = ref.watch(userProfileProvider).dateOfBirth;

    int years = now.year - dateOfBirth.year;
    int months = 0;
    int days = 0;

    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      years--;
      months = (12 - dateOfBirth.month) + now.month;
    } else {
      months = now.month - dateOfBirth.month;
    }

    if (now.day < dateOfBirth.day) {
      DateTime tempDate = DateTime(now.year, now.month, 0);
      days = tempDate.day + now.day - dateOfBirth.day;
      if (months == 0) {
        months = 11;
        years--;
      } else {
        months--;
      }
    } else {
      days = now.day - dateOfBirth.day;
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFF22577A),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 15)),
            const TopOfBar(),
            Background_body(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  ContentContainer(
                      child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ref.watch(userProfileProvider).name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${ref.watch(userProfileProvider).age ~/ 12} tahun ${ref.watch(userProfileProvider).age % 12} bulan',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '$days hari',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Spacer(),
                    ],
                  )),
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TitleContainer(
                          title: "Ambil Data",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: const Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [MqttDataFetcher()],
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
                          title: "Tinggi Badan/Umur",
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
                                          '${ref.watch(userProfileProvider).height}'),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 5)),
                                  const Column(
                                    children: [
                                      SizedBox(height: 15),
                                      UnitContainer(unit: 'cm'),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Column(
                                    children: [Tbbulan()],
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
                          title: "Berat Badan/Umur",
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
                                          '${ref.watch(userProfileProvider).weight}'),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 5)),
                                  const Column(
                                    children: [
                                      SizedBox(height: 15),
                                      UnitContainer(unit: 'kg'),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Bbbulan(),
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
                          title: "Indeks Massa Tubuh",
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ValueContainer(
                                      value: ref
                                          .watch(userProfileProvider)
                                          .bmi
                                          .toStringAsFixed(2)),
                                  const Spacer(),
                                  const Column(
                                    children: [
                                      BMIutil(),
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
                                          '${ref.watch(userProfileProvider).lingkarDada}'),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 5)),
                                  const Column(
                                    children: [
                                      SizedBox(height: 15),
                                      UnitContainer(unit: 'cm'),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      EditValueLD(
                                        callBack: _updateDataUser,
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
                                          '${ref.watch(userProfileProvider).lingkarKepala}'),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 5)),
                                  const Column(
                                    children: [
                                      SizedBox(height: 15),
                                      UnitContainer(unit: 'cm'),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      EditValueLK(
                                        callBack: _updateDataUser,
                                      ),
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
