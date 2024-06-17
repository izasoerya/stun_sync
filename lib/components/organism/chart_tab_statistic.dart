import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/models/user_profile.dart';

// Provider for chart data
final chartDataProvider =
    FutureProvider.family<List<UserProfile>, String>((ref, username) async {
  final sqLiteDB = SQLiteDB();
  final data = await sqLiteDB.getUserProfilesByUsername(username);
  return data;
});

class ChartData {
  ChartData(this.x, this.y, this.datetime);
  final int x;
  final double y;
  final DateTime datetime;
}

class ChartTab extends ConsumerStatefulWidget {
  final String username;
  const ChartTab({super.key, required this.username});

  @override
  _ChartTabState createState() => _ChartTabState();
}

class _ChartTabState extends ConsumerState<ChartTab> {
  String selectedChartType = 'Height';
  String? clickedPointData;

  @override
  Widget build(BuildContext context) {
    final chartDataAsync = ref.watch(chartDataProvider(widget.username));

    return ContentContainer(
      child: Column(
        children: [
          const Text('Chart Tab'),
          DropdownButton<String>(
            value: selectedChartType,
            onChanged: (String? newValue) {
              setState(() {
                selectedChartType = newValue!;
                clickedPointData =
                    null; // Clear clicked point data on chart type change
              });
            },
            items: <String>['Height', 'Weight', 'BMI']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          chartDataAsync.when(
            data: (userProfiles) {
              List<ChartData> chartData = [];
              switch (selectedChartType) {
                case 'Height':
                  chartData = userProfiles
                      .map((profile) => ChartData(profile.age.toInt(),
                          profile.height.toDouble(), profile.datetime))
                      .toList();
                  break;
                case 'Weight':
                  chartData = userProfiles
                      .map((profile) => ChartData(profile.age.toInt(),
                          profile.weight.toDouble(), profile.datetime))
                      .toList();
                  break;
                case 'BMI':
                  chartData = userProfiles.map((profile) {
                    double bmi = profile.weight /
                        ((profile.height / 100) * (profile.height / 100));
                    return ChartData(
                        profile.age.toInt(), bmi, profile.datetime);
                  }).toList();
                  break;
              }

              return Column(
                children: [
                  SfCartesianChart(
                    plotAreaBorderColor: Colors.white,
                    margin: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 10,
                      bottom: 10,
                    ),
                    primaryXAxis: const NumericAxis(
                      majorTickLines: MajorTickLines(width: 0),
                      axisLine: AxisLine(width: 0),
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    primaryYAxis: const NumericAxis(
                      majorTickLines: MajorTickLines(width: 0),
                      axisLine: AxisLine(width: 0),
                      labelStyle: TextStyle(color: Colors.transparent),
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    series: <CartesianSeries>[
                      LineSeries<ChartData, int>(
                        dataSource: chartData,
                        color: const Color.fromRGBO(34, 87, 122, 1),
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        markerSettings: const MarkerSettings(
                            color: Color.fromRGBO(34, 87, 122, 1),
                            isVisible: true),
                        onPointTap: (ChartPointDetails details) {
                          setState(() {
                            final pointData = chartData[details.pointIndex!];
                            clickedPointData =
                                'Datetime: ${pointData.datetime}, Value: ${pointData.y}';
                          });
                        },
                      ),
                    ],
                  ),
                  if (clickedPointData != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        clickedPointData!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
          ),
        ],
      ),
    );
  }
}
