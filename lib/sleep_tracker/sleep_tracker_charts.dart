// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_duration.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_duration_chart.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_quality.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_quality_chart.dart';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_output.dart';
import 'package:elcare_application/sleep_tracker/sleep_duration.dart';
import 'package:elcare_application/sleep_tracker/sleep_duration_chart.dart';
import 'package:elcare_application/sleep_tracker/sleep_quality.dart';
import 'package:elcare_application/sleep_tracker/sleep_quality_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class SleepTrackerCharts extends StatefulWidget {
  SleepTrackerCharts({Key? key}) : super(key: key);

  @override
  State<SleepTrackerCharts> createState() => _SleepTrackerChartsState();
}

class _SleepTrackerChartsState extends State<SleepTrackerCharts> {
  late final Box sleepQualityBox;
  late final Box sleepDurationBox;

  var qualityKeyList = [];
  var qualityValueList = [];

  var durationKeyList = [];
  var durationValueList = [];


  var firebaseQualityKeyList = [];
  var firebaseQualityValueList = [];
  var firebaseDurationKeyList = [];
  var firebaseDurationValueList = [];


  //TODO: sort these arrays
  var allQualityKeys = [];
  var allDurationKeys = [];

  void fillQualityKeys() {
    if (allQualityKeys.length > 7) {
      for (int i = 6; i >= 0; i--) {
        qualityKeyList
            .add(allQualityKeys.elementAt(allQualityKeys.length - 1 - i));
      }
    } else {
      for (int i = 0; i < allQualityKeys.length; i++) {
        qualityKeyList.add(allQualityKeys.elementAt(i));
      }
    }
    firebaseQualityKeyList = qualityKeyList;
  }

  void fillDurationKeys() {
    if (allDurationKeys.length > 7) {
      for (int i = 6; i >= 0; i--) {
        durationKeyList
            .add(allDurationKeys.elementAt(allDurationKeys.length - 1 - i));
      }
    } else {
      for (int i = 0; i < allDurationKeys.length; i++) {
        durationKeyList.add(allDurationKeys.elementAt(i));
      }
    }
    firebaseDurationKeyList = durationKeyList;
  }

  void fillQualityValues() {
    for (int i = 0; i < qualityKeyList.length; i++) {
      qualityValueList.add(_getInfo(qualityKeyList[i], 1));
    }
    firebaseQualityValueList = qualityValueList;
  }

  void fillDurationValues() {
    for (int i = 0; i < durationKeyList.length; i++) {
      durationValueList.add(_getInfo(durationKeyList[i], 2));
    }
    firebaseDurationValueList = durationValueList;
  }

///////////////////////////////////////////////////
  ///
  _addInfo(String key, String value, int boxNum) async {
    if (boxNum == 1) {
      sleepQualityBox.put(key, value);
    } else {
      sleepDurationBox.put(key, value);
    }
  }

  ///
////////////////////////////////////////////////

  _getInfo(String key, int boxNum) {
    if (boxNum == 1) {
      return sleepQualityBox.get(key);
    } else {
      return sleepDurationBox.get(key);
    }
  }

  List _getKeys(int boxNum) {
    if (boxNum == 1) {
      return sleepQualityBox.keys.toList();
    } else {
      return sleepDurationBox.keys.toList();
    }
  }

  _getValues(String key, int boxNum) {
    if (boxNum == 1) {
      return sleepQualityBox.get(key);
    } else {
      return sleepDurationBox.get(key);
    }
  }

  void addSleepQualityDatatoChart() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    for (int i = 0; i < qualityKeyList.length; i++) {
      DateTime addDT = format.parse(qualityKeyList[i]);
      String toPass = "${addDT.day}/${addDT.month}";
      qualityData.add(SleepQuality(
          date: toPass,
          quality: double.parse(_getInfo(qualityKeyList[i], 1)),
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
          duration: double.parse(_getInfo(durationKeyList[i], 2)),
          backColor: charts.ColorUtil.fromDartColor(Colors.tealAccent)));
    }
  }

  @override
  void initState() {
    super.initState();
    sleepQualityBox = Hive.box('sleepQualityBox'); //box 1
    sleepDurationBox = Hive.box('sleepDurationBox'); //box 2
    Hive.openBox('sleepQualityBox');
    Hive.openBox('sleepDurationBox');

    allQualityKeys = _getKeys(1);
    allDurationKeys = _getKeys(2);

    // var heyDay;
    // for(int i=1; i<=10;i++){
    //   heyDay =  DateTime.now().add( Duration(days:i));
    //   _addInfo("${heyDay.year}-${heyDay.month}-${heyDay.day} 00:00:00.000", "${i*9}", 1);
    //   _addInfo("${heyDay.year}-${heyDay.month}-${heyDay.day} 00:00:00.000", "${i*9}", 2);
    // }

    // print("Data added");

    List<DateTime> newAllQualityKeys = [];
    List<DateTime> newAllDurationKeys = [];
    DateFormat format = DateFormat("yyyy-MM-dd");

    for (int i = 0; i < allQualityKeys.length; i++) {
      newAllQualityKeys.add(format.parse(allQualityKeys[i]));
    }

    for (int i = 0; i < allDurationKeys.length; i++) {
      newAllDurationKeys.add(format.parse(allDurationKeys[i]));
    }

    newAllQualityKeys.sort((a, b) => a.compareTo(b));
    newAllDurationKeys.sort((a, b) => a.compareTo(b));

    allQualityKeys = [];
    allDurationKeys = [];

    for (int i = 0; i < newAllQualityKeys.length; i++) {
      allQualityKeys.add(
          "${newAllQualityKeys[i].year}-${newAllQualityKeys[i].month}-${newAllQualityKeys[i].day} 00:00:00.000");
    }

    for (int i = 0; i < newAllDurationKeys.length; i++) {
      allDurationKeys.add(
          "${newAllDurationKeys[i].year}-${newAllDurationKeys[i].month}-${newAllDurationKeys[i].day} 00:00:00.000");
    }

    print(allQualityKeys);
    print(allDurationKeys);




    fillQualityKeys();
    fillQualityValues();

    fillDurationKeys();
    fillDurationValues();

    print(durationValueList);

    addSleepQualityDatatoChart();
    addSleepDurationDatatoChart();

    String nnm = "2022-1-9 00:00:00.000";
  }

  List<SleepDuration> durationData = [];

  List<SleepQuality> qualityData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fonts/images/regular_user_back.jpg"),
              fit: BoxFit.cover),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff232526), Color(0xff414345)]),
        ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  "Sleep Data",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(height: 10),
                TextButton.icon(
                    onPressed: () async{
                      print(firebaseDurationValueList);
                      print(firebaseQualityKeyList);
                      print(firebaseDurationKeyList);
                      print(firebaseQualityValueList);


                      sharedPrefInit();
                      String email = await getString("email");
                      print(email);

                      CollectionReference users = FirebaseFirestore.instance.collection("users");
                      users.doc('$email').update(
                        {
                          "durationKeys" : FieldValue.arrayUnion(firebaseDurationKeyList),
                          "durationValues":FieldValue.arrayUnion(firebaseDurationValueList),
                          "qualityKeys":FieldValue.arrayUnion(firebaseQualityKeyList),
                          "qualityValues":FieldValue.arrayUnion(firebaseQualityValueList)
                        
                        }
                      );
                      print(users.doc('$email').get());

                      DocumentSnapshot variable =
                    await users.doc('$email').get();
                 
                print(variable['durationKeys']);

                    },
                    style: TextButton.styleFrom(primary: Colors.amberAccent,backgroundColor: Colors.amber),
                    icon: Icon(Icons.upload,color: Colors.white,),
                    label: Text("Send data to doctor", style:TextStyle(color: Colors.white))),
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
