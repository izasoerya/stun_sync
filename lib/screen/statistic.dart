import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/components/atom/property_slider.dart';
import 'package:stun_sync/components/organism/chart_tab_statistic.dart';
import 'package:stun_sync/components/organism/heading_statistic.dart';
import 'package:stun_sync/components/organism/height_tab_statistic.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class StatisticPage extends ConsumerWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color.fromRGBO(238, 238, 238, 1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 30)),
              HeadingStatistic(),
              PropertySlider(),
              ChartTab(username: ref.watch(userProfileProvider).name),
              HeightTab(),
            ],
          ),
        ),
      ),
    );
  }
}
