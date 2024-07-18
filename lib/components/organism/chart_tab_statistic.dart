import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:intl/intl.dart'; // Add this line to import DateFormat

// Provider for chart data

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
  final chartDataProvider =
      FutureProvider.family<List<UserProfile>, String>((ref, username) async {
    const sqLiteDB = SQLiteDB();
    final data = await sqLiteDB.getUserProfilesByUsername(username);
    print(data);

    return data;
  });

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
                      .map((profile) => ChartData(profile.datetime,
                          profile.height.toDouble(), profile.datetime))
                      .toList();
                  // Use dummy data for height
                  // List<Map<String, dynamic>> dummyHeightData = [
                  //   {'date': '2023-12-16', 'height': 100.0},
                  //   {'date': '2024-01-13', 'height': 98.0},
                  //   {'date': '2024-02-15', 'height': 98.0},
                  //   {'date': '2024-03-09', 'height': 98.0},
                  //   {'date': '2024-04-19', 'height': 98.0},
                  //   {'date': '2024-05-14', 'height': 99.0},
                  //   {'date': '2024-06-21', 'height': 102.0},
                  // ];
                  // chartData = chartData.map((data) {
                  //   DateTime date = DateTime.parse(profile);
                  //   return ChartData(date, data['height'], date);
                  // }).toList();
                  break;
                case 'Weight':
                  chartData = userProfiles
                      .map((profile) => ChartData(profile.datetime,
                          profile.weight.toDouble(), profile.datetime))
                      .toList();
                  // List<Map<String, dynamic>> dummyWeightData = [
                  //   {'date': '2023-12-16', 'weight': 17.6},
                  //   {'date': '2024-01-13', 'weight': 17.5},
                  //   {'date': '2024-02-15', 'weight': 17.5},
                  //   {'date': '2024-03-09', 'weight': 17.6},
                  //   {'date': '2024-04-19', 'weight': 17.8},
                  //   {'date': '2024-05-14', 'weight': 18.2},
                  //   {'date': '2024-06-21', 'weight': 18.95},
                  // ];

                  // chartData = dummyWeightData.map((data) {
                  //   DateTime date = DateTime.parse(data['date']);
                  //   return ChartData(date, data['weight'], date);
                  // }).toList();
                  break;
                case 'BMI':
                  chartData = userProfiles.map((profile) {
                    double bmi = profile.weight /
                        ((profile.height / 100) * (profile.height / 100));
                    return ChartData(profile.datetime, bmi, profile.datetime);
                  }).toList();
                  // List<Map<String, dynamic>> dummyBMIData = [
                  //   {'date': '2023-12-16', 'bmi': 51.0},
                  //   {'date': '2024-01-13', 'bmi': 50.5},
                  //   {'date': '2024-02-15', 'bmi': 51.0},
                  //   {'date': '2024-03-09', 'bmi': 51.0},
                  //   {'date': '2024-04-19', 'bmi': 51.0},
                  //   {'date': '2024-05-14', 'bmi': 51.0},
                  //   {'date': '2024-06-21', 'bmi': 51.5},
                  // ];

                  // chartData = dummyBMIData.map((data) {
                  //   DateTime date = DateTime.parse(data['date']);
                  //   return ChartData(date, data['bmi'], date);
                  // }).toList();
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
                    primaryXAxis: DateTimeAxis(
                      majorTickLines: const MajorTickLines(width: 0),
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      minimum: DateTime(2024, 7, 1),
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
