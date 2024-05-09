import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stun_sync/components/atom/content_container.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

List<ChartData> chartData = [
  ChartData(2010, 35),
  ChartData(2011, 28),
  ChartData(2012, 34),
  ChartData(2013, 32),
  ChartData(2014, 40),
];

class ChartTab extends StatelessWidget {
  const ChartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: Column(
        children: [
          Text('Chart Tab'),
          SfCartesianChart(
            plotAreaBorderColor: Colors.white,
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
              bottom: 10,
            ),
            primaryXAxis: NumericAxis(
              majorTickLines: MajorTickLines(width: 0),
              axisLine: AxisLine(width: 0),
              majorGridLines: MajorGridLines(
                  width: 0), // This will remove the X-axis grid lines
            ),
            primaryYAxis: NumericAxis(
              majorTickLines: MajorTickLines(width: 0),
              axisLine: AxisLine(width: 0),
              labelStyle: TextStyle(color: Colors.transparent),
              majorGridLines: MajorGridLines(
                  width: 0), // This will remove the Y-axis grid lines
            ),
            series: <CartesianSeries>[
              // Renders line chart
              LineSeries<ChartData, int>(
                dataSource: chartData,
                color: Color.fromRGBO(34, 87, 122, 1),
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                markerSettings: MarkerSettings(
                    color: Color.fromRGBO(34, 87, 122, 1),
                    isVisible: true), // This will make the data points visible
              ),
            ],
          ),
        ],
      ),
    );
  }
}
