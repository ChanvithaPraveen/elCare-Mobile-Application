import 'package:charts_flutter/flutter.dart' as charts;

class SleepDuration{
  String? date;
  double? duration;
  charts.Color backColor;

  SleepDuration(
    {
      required this.date,
      required this.duration,
      required this.backColor
    }
  );

}

