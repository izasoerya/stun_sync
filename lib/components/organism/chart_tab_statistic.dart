import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:intl/intl.dart'; // Add this line to import DateFormat

// Provider for chart data
final chartDataProvider =
    FutureProvider.family<List<UserProfile>, String>((ref, username) async {
  const sqLiteDB = SQLiteDB();
  final data = await sqLiteDB.getUserProfilesByUsername(username);
  return data;
});

class ChartData {
  ChartData(this.x, this.y, this.datetime);
  final DateTime x;
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
                  // chartData = userProfiles
                  //     .map((profile) => ChartData(profile.datetime,
                  //         profile.height.toDouble(), profile.datetime))
                  //     .toList();
                  // break;
                  // Use dummy data for height
                  List<Map<String, dynamic>> dummyHeightData = [
                    {'date': '2023-10-14', 'height': 63.5},
                    {'date': '2023-11-11', 'height': 63.5},
                    {'date': '2023-12-10', 'height': 63.5},
                    {'date': '2024-01-17', 'height': 66.0},
                    {'date': '2024-02-15', 'height': 72.0},
                    {'date': '2024-03-09', 'height': 72.0},
                    {'date': '2024-04-19', 'height': 72.0},
                    {'date': '2024-05-14', 'height': 72.5},
                    {'date': '2024-06-13', 'height': 81.5},
                  ];

                  chartData = dummyHeightData.map((data) {
                    DateTime date = DateTime.parse(data['date']);
                    return ChartData(date, data['height'], date);
                  }).toList();
                  break;
                case 'Weight':
                  // chartData = userProfiles
                  //     .map((profile) => ChartData(profile.datetime,
                  //         profile.weight.toDouble(), profile.datetime))
                  //     .toList();
                  // break;
                  List<Map<String, dynamic>> dummyWeightData = [
                    {'date': '2023-10-14', 'weight': 6.45},
                    {'date': '2023-11-11', 'weight': 6.35},
                    {'date': '2023-12-10', 'weight': 6.10},
                    {'date': '2024-01-17', 'weight': 6.70},
                    {'date': '2024-02-15', 'weight': 6.90},
                    {'date': '2024-03-09', 'weight': 7.10},
                    {'date': '2024-04-19', 'weight': 6.80},
                    {'date': '2024-05-14', 'weight': 7.00},
                    {'date': '2024-06-13', 'weight': 7.70},
                  ];

                  chartData = dummyWeightData.map((data) {
                    DateTime date = DateTime.parse(data['date']);
                    return ChartData(date, data['weight'], date);
                  }).toList();
                  break;
                case 'BMI':
                  // chartData = userProfiles.map((profile) {
                  //   double bmi = profile.weight /
                  //       ((profile.height / 100) * (profile.height / 100));
                  //   return ChartData(profile.datetime, bmi, profile.datetime);
                  // }).toList();
                  // break;
                  List<Map<String, dynamic>> dummyBMIData = [
                    {'date': '2023-10-14', 'bmi': 16.01},
                    {'date': '2023-11-11', 'bmi': 15.76},
                    {'date': '2023-12-10', 'bmi': 15.10},
                    {'date': '2024-01-17', 'bmi': 15.36},
                    {'date': '2024-02-15', 'bmi': 13.31},
                    {'date': '2024-03-09', 'bmi': 13.69},
                    {'date': '2024-04-19', 'bmi': 13.11},
                    {'date': '2024-05-14', 'bmi': 13.30},
                    {'date': '2024-06-13', 'bmi': 11.61},
                  ];

                  chartData = dummyBMIData.map((data) {
                    DateTime date = DateTime.parse(data['date']);
                    return ChartData(date, data['bmi'], date);
                  }).toList();
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
                    primaryXAxis: DateTimeAxis(
                      majorTickLines: const MajorTickLines(width: 0),
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      dateFormat: DateFormat.yMMM(), // Display year and month
                      labelStyle: const TextStyle(
                        fontSize:
                            10, // Adjust the font size to make it more compact
                        color: Colors.black, // Adjust the color if needed
                      ),
                    ),
                    primaryYAxis: const NumericAxis(
                      majorTickLines: MajorTickLines(width: 0),
                      axisLine: AxisLine(width: 0),
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    series: <CartesianSeries>[
                      LineSeries<ChartData, DateTime>(
                        dataSource: chartData.toList(),
                        color: const Color.fromRGBO(34, 87, 122, 1),
                        xValueMapper: (ChartData data, _) =>
                            DateTime(data.x.year, data.x.month, data.x.day),
                        yValueMapper: (ChartData data, _) => data.y,
                        markerSettings: const MarkerSettings(
                            color: Color.fromRGBO(34, 87, 122, 1),
                            isVisible: true),
                        onPointTap: (ChartPointDetails details) {
                          setState(() {
                            final pointData = chartData[details.pointIndex!];
                            clickedPointData =
                                'Datetime: ${pointData.x.toString().substring(0, 10)}, Value: ${pointData.y}';
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
