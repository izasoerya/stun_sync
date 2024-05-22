import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/property_slider.dart';
import 'package:stun_sync/components/organism/chart_tab_statistic.dart';
import 'package:stun_sync/components/organism/heading_statistic.dart';
import 'package:stun_sync/components/organism/height_tab_statistic.dart';
import 'package:stun_sync/components/organism/recomendation_tab_statistic.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(238, 238, 238, 1),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            HeadingStatistic(),
            PropertySlider(),
            ChartTab(),
            HeightTab(),
            RecommendationTab(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
