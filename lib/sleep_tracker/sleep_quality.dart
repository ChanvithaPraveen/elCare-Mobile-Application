import 'package:charts_flutter/flutter.dart' as charts;

class SleepQuality{
  String? date;
  double? quality;
  charts.Color backColor;

  SleepQuality(
    {
      required this.date,
      required this.quality,
      required this.backColor
    }
  );

}

