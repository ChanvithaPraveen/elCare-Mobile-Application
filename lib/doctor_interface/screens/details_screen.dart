import 'dart:ui';

// import 'package:doctor_interface/screens/pill_timer_info_sc.dart';
// import 'package:doctor_interface/screens/home_sc.dart';
import 'package:elcare_application/doctor_interface/classes/patient.dart';
import 'package:elcare_application/doctor_user_menu.dart';
import 'package:elcare_application/doctor_interface/screens/pill_timer_info.dart';
import 'package:elcare_application/sleep_tracker/sleep_tracker_firebase_charts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientDetailsScreen extends StatelessWidget {
  final PatientDetails eachPatient;

  PatientDetailsScreen({
    required this.eachPatient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        centerTitle: true,
        elevation: 5.0,
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Patient Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fonts/images/regular_user_back.jpg"),
              fit: BoxFit.cover),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff232526), Color(0xff414345)]),
        ),
        padding: EdgeInsets.all(15),
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(height: 110.0),
            Container(
              //  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
              child: Column(children: [
                FlatButton(
                  onPressed: () {
                    Get.to(() => SleepTrackerFirebaseCharts(patientEmail: "Hello",));

                    //     Sleep Tracker chart direct/////////////////////
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_alarm_sharp,
                              size: 40,
                              color: Colors.white70,
                            ),
                            Text(
                              "  Sleep Tracker details",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ],
                  ),
                ),
              ]),
            ), // height: 100.0
            const SizedBox(
              height: 30.0,
            ),
            Container(
              //  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFE6197), Color(0xFFFFB463)],
                  // colors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
              child: Column(children: [
                FlatButton(
                  //   padding: EdgeInsets.symmetric(horizontal: 0, vertical: 70),

                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PillTimerInfo(eachPatient: eachPatient),
                        ));
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_alarm_sharp,
                              size: 40,
                              color: Colors.white70,
                            ),
                            Text(
                              'Pill Timer Details',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
