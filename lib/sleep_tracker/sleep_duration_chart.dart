// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_duration.dart';
import 'package:elcare_application/sleep_tracker/sleep_duration.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class SleepDurationChart extends StatelessWidget {
  // const SleepDurationChart({ Key? key }) : super(key: key);
  final List<SleepDuration> data;
  const SleepDurationChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SleepDuration,String>> durations = [
      charts.Series(
        id: "durations",
        data: data,
        domainFn: (SleepDuration duration, _) => duration.date??"",
        measureFn: (SleepDuration duration, _) => duration.duration??0,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
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
                "Sleep Duration",
                //style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(durations, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}