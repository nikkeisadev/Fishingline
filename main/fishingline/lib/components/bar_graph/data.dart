import 'package:fishingline/components/bar_graph/individualbar.dart';

class BarData {
  final double janAmount;
  final double febAmount;
  final double marchAmount;
  final double aprAmount;
  final double mayAmount;
  final double juneAmount;
  final double julyAmount;
  final double augAmount;
  final double septAmount;
  final double octAmount;
  final double novAmount;
  final double decAmount;

  BarData({
    required this.janAmount,
    required this.febAmount,
    required this.marchAmount,
    required this.aprAmount,
    required this.mayAmount,
    required this.juneAmount,
    required this.julyAmount,
    required this.augAmount,
    required this.septAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: janAmount),
      IndividualBar(x: 1, y: febAmount),
      IndividualBar(x: 2, y: marchAmount),
      IndividualBar(x: 3, y: aprAmount),
      IndividualBar(x: 4, y: mayAmount),
      IndividualBar(x: 5, y: juneAmount),
      IndividualBar(x: 6, y: julyAmount),
      IndividualBar(x: 7, y: augAmount),
      IndividualBar(x: 8, y: septAmount),
      IndividualBar(x: 9, y: octAmount),
      IndividualBar(x: 10, y: novAmount),
      IndividualBar(x: 11, y: decAmount),
    ];
  }
}