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
            getTextStyles: (value) => const TextStyle(
              fontSize: 12,
              color: Colors.white, // Set the text color to white
              fontWeight: FontWeight.bold, // Set the text style to bold
            ),
            margin: 10,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Jan\n' + monthlySummary[0].truncate().toString();
                case 1:
                  return 'Feb\n' + monthlySummary[1].truncate().toString();
                case 2:
                  return 'Mar\n' + monthlySummary[2].truncate().toString();
                case 3:
                  return 'Apr\n' + monthlySummary[3].truncate().toString();
                case 4:
                  return 'May\n' + monthlySummary[4].truncate().toString();
                case 5:
                  return 'Jun\n' + monthlySummary[5].truncate().toString();
                case 6:
                  return 'Jul\n' + monthlySummary[6].truncate().toString();
                case 7:
                  return 'Aug\n' + monthlySummary[7].truncate().toString();
                case 8:
                  return 'Sep\n' + monthlySummary[8].truncate().toString();
                case 9:
                  return 'Oct\n' + monthlySummary[9].truncate().toString();
                case 10:
                  return 'Nov\n' + monthlySummary[10].truncate().toString();
                case 11:
                  return 'Dec\n' + monthlySummary[11].truncate().toString();
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
                    colors: [Color.fromARGB(255, 255, 187, 0)],
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