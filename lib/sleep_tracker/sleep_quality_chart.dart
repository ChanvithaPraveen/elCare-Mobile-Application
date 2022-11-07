// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_duration.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_quality.dart';
import 'package:elcare_application/sleep_tracker/sleep_quality.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class SleepQualityChart extends StatelessWidget {
  // const SleepDurationChart({ Key? key }) : super(key: key);
  final List<SleepQuality> data;
  const SleepQualityChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SleepQuality,String>> qualities = [
      charts.Series(
        id: "qualities",
        data: data,
        domainFn: (SleepQuality duration, _) => duration.date??"",
        measureFn: (SleepQuality duration, _) => duration.quality??0,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.redAccent),
        //fillColorFn:   (SleepDuration duration, _) => duration.backColor,
        
      )
    ];
     
    return Container(
      height: 300,
      padding: EdgeInsets.all(30),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Sleep Quality",
                //style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(qualities, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}