import 'package:fishingline/components/bar_graph/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraphActivity extends StatelessWidget {
  final List monthlySummary;
  const BarGraphActivity({
    Key? key,
    required this.monthlySummary,
  });

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
      janAmount: monthlySummary[0],
      febAmount: monthlySummary[1],
      marchAmount: monthlySummary[2],
      aprAmount: monthlySummary[3],
      mayAmount: monthlySummary[4],
      juneAmount: monthlySummary[5],
      julyAmount: monthlySummary[6],
      augAmount: monthlySummary[7],
      septAmount: monthlySummary[8],
      octAmount: monthlySummary[9],
      novAmount: monthlySummary[10],
      decAmount: monthlySummary[11],
    );

    barData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 20,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(fontSize: 12),
            margin: 10,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Jan';
                case 1:
                  return 'Feb';
                case 2:
                  return 'Mar';
                case 3:
                  return 'Apr';
                case 4:
                  return 'May';
                case 5:
                  return 'Jun';
                case 6:
                  return 'Jul';
                case 7:
                  return 'Aug';
                case 8:
                  return 'Sep';
                case 9:
                  return 'Oct';
                case 10:
                  return 'Nov';
                case 11:
                  return 'Dec';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(showTitles: false), // Hide the left side numbers
        ),
        barGroups: barData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    y: data.y,
                    width: 25,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      y: 20,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}