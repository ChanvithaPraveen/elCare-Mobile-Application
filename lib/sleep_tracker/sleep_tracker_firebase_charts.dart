// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_duration.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_duration_chart.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_quality.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_quality_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elcare_application/sleep_tracker/sleep_duration.dart';
import 'package:elcare_application/sleep_tracker/sleep_duration_chart.dart';
import 'package:elcare_application/sleep_tracker/sleep_quality.dart';
import 'package:elcare_application/sleep_tracker/sleep_quality_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class SleepTrackerFirebaseCharts extends StatefulWidget {
  final String? patientEmail;
  SleepTrackerFirebaseCharts({Key? key, @required this.patientEmail}) : super(key: key);

  @override
  State<SleepTrackerFirebaseCharts> createState() =>
      _SleepTrackerFirebaseChartsState(this.patientEmail);
}

class _SleepTrackerFirebaseChartsState
    extends State<SleepTrackerFirebaseCharts> {

  String? patientEmail;    
  _SleepTrackerFirebaseChartsState(this.patientEmail);
  var qualityKeyList = [];
  var qualityValueList = [];

  var durationKeyList = [];
  var durationValueList = [];

  void addSleepQualityDatatoChart() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    for (int i = 0; i < qualityKeyList.length; i++) {
      DateTime addDT = format.parse(qualityKeyList[i]);
      String toPass = "${addDT.day}/${addDT.month}";
      qualityData.add(SleepQuality(
          date: toPass,
          quality: double.parse(qualityValueList[i]),
          backColor: charts.ColorUtil.fromDartColor(Colors.tealAccent)));
    }
  }

  void addSleepDurationDatatoChart() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    for (int i = 0; i < durationKeyList.length; i++) {
      DateTime addDT = format.parse(durationKeyList[i]);
      String toPass = "${addDT.day}/${addDT.month}";
      durationData.add(SleepDuration(
          date: toPass,
          duration: double.parse(durationValueList[i]),
          backColor: charts.ColorUtil.fromDartColor(Colors.tealAccent)));
    }
  }

  void addAllData() async {
    //String patientEmail;
    // patientEmail = 'le@gmail.com';
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    DocumentSnapshot variable = await users.doc('$patientEmail').get();

    durationValueList = await variable['durationValues'];
    durationKeyList = await variable['durationKeys'];
    qualityKeyList = await variable['qualityKeys'];
    qualityValueList = await variable['qualityValues'];
    print(qualityValueList);
    print(await variable['qualityValues']);
  }

  @override
  void initState() {
    super.initState();
    addAllData();
    
       
    addSleepDurationDatatoChart();
    addSleepQualityDatatoChart();
   
   
    print("adp");
    print(qualityValueList);
    
  }

  List<SleepDuration> durationData = [];

  List<SleepQuality> qualityData = [];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blue[900],
        title: Text('Sleep Data'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff232526), Color(0xff414345)])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                
                SizedBox(height: 10),
                TextButton.icon(
                    onPressed: () async{
                      setState(() {
                         addSleepQualityDatatoChart();
                      addSleepDurationDatatoChart();
                      });
                     

                    },
                    style: TextButton.styleFrom(primary: Colors.amberAccent,backgroundColor: Colors.amber),
                    icon: Icon(Icons.download,color: Colors.white,),
                    label: Text("Get Sleep Data of the Patient", style:TextStyle(color: Colors.white))),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                          child: SleepDurationChart(
                        data: durationData,
                      )),
                      Center(
                          child: SleepQualityChart(
                        data: qualityData,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
