import 'package:elcare_application/alarm_and_pill/Alarm/alarm_page.dart';
import 'package:elcare_application/alarm_and_pill/pages/pthome.dart';
import 'package:elcare_application/emergency_caller/emergency_caller.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_input.dart';
import 'package:elcare_application/sleep_tracker/sleep_tracker.dart';
import 'package:elcare_application/sleep_tracker/sleep_tracker_charts.dart';
import 'package:elcare_application/sleep_tracker/sleep_tracker_firebase_charts.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/User_Personal_Page/user_personal_details.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/views/personal_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:slide_digital_clock/slide_digital_clock.dart';

class RegularUserMain extends StatefulWidget {
  const RegularUserMain({Key? key}) : super(key: key);

  @override
  _RegularUserMainState createState() => _RegularUserMainState();
}

class _RegularUserMainState extends State<RegularUserMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/fonts/images/logo.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  color: Colors.white,
                  indent: 60,
                  endIndent: 60,
                ),
                DigitalClock(
                  digitAnimationStyle: Curves.elasticOut,
                  is24HourTimeFormat: false,
                  hourMinuteDigitDecoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  secondDigitDecoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  areaDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
                  ),
                  hourMinuteDigitTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                  ),
                  amPmDigitTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: Colors.white,
                  indent: 60,
                  endIndent: 60,
                ),
                SizedBox(height: 5),
                MaterialButton(
                  padding: EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent[800],

                  elevation: 8.0,
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/fonts/images/pilltimebutton.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text("Pill Time", style: TextStyle(fontSize: 25)),
                        ),
                      ],
                    ),
                  ),
                  // ),
                  onPressed: () {
                    Get.to(()=>PTHome());
                    // sharedPrefInit();
                    // putString("logged", "false");
                    // print('Tapped');
                  },
                ),
                MaterialButton(
                  padding: EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent[800],

                  elevation: 8.0,
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/fonts/images/sleeptrackerbutton.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sleep", style: TextStyle(fontSize: 25)),
                              Text("Tracker", style: TextStyle(fontSize: 25)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlarmPage()),
                    );
                    print('Tapped');
                  },
                ),
                MaterialButton(
                  padding: EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent[800],

                  elevation: 8.0,
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/fonts/images/profilebutton.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text("Profile", style: TextStyle(fontSize: 25)),
                        ),
                      ],
                    ),
                  ),
                  // ),
                  onPressed: () {
                    Get.to(User_Profile_Page());
                    print('Tapped');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EmergencyCaller()));
        },
        child: const Icon(Icons.call),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
