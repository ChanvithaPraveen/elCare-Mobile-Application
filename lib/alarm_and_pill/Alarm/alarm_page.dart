import 'dart:ui';
import 'package:elcare_application/alarm_and_pill/Alarm/delete_alert.dart';
import 'package:elcare_application/alarm_and_pill/Alarm/edit_alarm.dart';
import 'package:elcare_application/alarm_and_pill/Local_Notification/local_notification.dart';
import 'package:elcare_application/alarm_and_pill/Local_Notification/medicine_took_yes_no.dart';
import 'package:elcare_application/sleep_tracker/sleep_tracker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Alarm_Data/alarm_info.dart';
// import 'package:alarm_manager/Local_Notification/local_notification.dart';
// import 'package:alarm_manager/Local_Notification/medicine_took_yes_no.dart';

bool Adding = false;

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickNotification);

  // void onClickNotification(String? payload) =>
  //     Navigator.pushNamed(context, '/edit_alarm'); ////////////////////////////////////////////////

  void onClickNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Confirmation_MSG(),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
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
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            SizedBox(
              width: 20,
            ),
            // Icon(
            //   Icons.ad_units_outlined,
            //   size: 30,
            //   color: Colors.white70,
            // ),
            Text(
              "Sleep Tracker",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () async {

                      ListIndex =
                          allalarms[allalarms.length - 1].AlarmNumber + 1;
                      String text = '';
                      Vibrateok = false;
                      SelectedTimeInDateTimeFormat = TimeOfDay.now();
                      SelectedTimeInStringFormat = "";
                      Weekdays = [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                      ];
                      WeekdayButtonColor = [
                        Colors.white10,
                        Colors.white10,
                        Colors.white10,
                        Colors.white10,
                        Colors.white10,
                        Colors.white10,
                        Colors.white10
                      ];
                      Append = true;
                      // Navigator.pop(context);
                      // Get.to(EditAlarm());

// Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => EditAlarm()),
//   );
                      Get.off(() => EditAlarm());


                    },
                    style: TextButton.styleFrom(
                        primary: Colors.amberAccent,
                        backgroundColor: Colors.amber),
                    icon: Icon(
                      Icons.alarm_add,
                      color: Colors.white,
                    ),
                    label: Text("Add Alarm",
                        style: TextStyle(color: Colors.white))),
                SizedBox(
                  width: 10,
                ),
                TextButton.icon(
                    onPressed: () async {

// Get.off(()=>SleepTracker());
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SleepTracker()),
  );







                    },
                    style: TextButton.styleFrom(
                        primary: Colors.amberAccent,
                        backgroundColor: Colors.greenAccent[700]),
                    icon: Icon(
                      Icons.airline_seat_flat,
                      color: Colors.white,
                    ),
                    label: Text("Track Sleep",
                        style: TextStyle(color: Colors.white))),
              ],
            ),
///////////////////////////////////////////////////////////////////////////////////////////////
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 45,
//                   width: 150,
//                   child: FlatButton(
//                     ///////////////////////////////////////////////////////
//                     /////////////////////////// Yes pick  //////////////////
//                     onPressed: () {
//                       ListIndex =
//                           allalarms[allalarms.length - 1].AlarmNumber + 1;
//                       String text = '';
//                       Vibrateok = false;
//                       SelectedTimeInDateTimeFormat = TimeOfDay.now();
//                       SelectedTimeInStringFormat = "";
//                       Weekdays = [
//                         false,
//                         false,
//                         false,
//                         false,
//                         false,
//                         false,
//                         false
//                       ];
//                       WeekdayButtonColor = [
//                         Colors.white10,
//                         Colors.white10,
//                         Colors.white10,
//                         Colors.white10,
//                         Colors.white10,
//                         Colors.white10,
//                         Colors.white10
//                       ];
//                       Append = true;
//                       // Navigator.pop(context);
//                       // Get.to(EditAlarm());

// // Navigator.push(
// //     context,
// //     MaterialPageRoute(builder: (context) => EditAlarm()),
// //   );
//                       Get.off(() => EditAlarm());
//                       // Navigator.pushNamed(context, '/edit_alarm');
//                     }, ////////////////////////////////////////////////////////
//                     child: Column(
//                       children: [
//                         Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.add_alarm_sharp,
//                                 size: 25,
//                                 color: Colors.white70,
//                               ),
//                               Text(
//                                 "  Add Alarm",
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   color: Colors.white70,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // height: 100.0,
//                   decoration: BoxDecoration(
//                     color: Colors.indigoAccent,
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                 ),
//                 SizedBox(width: 2),
//                 Container(
//                   height: 45,
//                   width: 140,
//                   child: FlatButton(
//                     ///////////////////////////////////////////////////////
//                     /////////////////////////// Yes pick  //////////////////
//                     onPressed: () {
//                       Get.to(SleepTracker());
//                     }, ////////////////////////////////////////////////////////
//                     child: Column(
//                       children: [
//                         Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.airline_seat_flat,
//                                 size: 25,
//                                 color: Colors.white70,
//                               ),
//                               Text(
//                                 "  Track Sleep",
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   color: Colors.white70,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // height: 100.0,
//                   decoration: BoxDecoration(
//                     color: Colors.indigoAccent,
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                 ),
//               ],
//             ),


///////////////////////////////////////////////////////////////////////////////////////////////

            SizedBox(
              height: 1,
            ),
            Expanded(
              child: ListView(
                children: alarms.map((alarm) {
                  ListIndex += 1;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Colors.blue.shade900, Colors.blue.shade700,Colors.blue.shade500],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(
                                  Icons.label,
                                  color: Colors.white70,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 24.0,
                                ),
                                Text(
                                  '${alarm.description}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: alarm.isActive,
                              onChanged: (bool value) {
                                if (alarm.isActive == false)
                                  setState(() {
                                    alarm.isActive = true;
                                  });
                                else
                                  setState(() {
                                    alarm.isActive = false;
                                  });
                              },
                            ),
                          ],
                        ),

                        //for 7 days
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "M",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // height: 100.0,
                                  decoration: BoxDecoration(
                                    color: alarm.WeekdayButtonColor[0],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "T",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // height: 100.0,
                                  decoration: BoxDecoration(
                                    color: alarm.WeekdayButtonColor[1],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "W",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // height: 100.0,
                                  decoration: BoxDecoration(
                                    color: alarm.WeekdayButtonColor[2],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "T",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // height: 100.0,
                                  decoration: BoxDecoration(
                                    color: alarm.WeekdayButtonColor[3],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "F",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // height: 100.0,
                                  decoration: BoxDecoration(
                                    color: alarm.WeekdayButtonColor[4],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "S",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // height: 100.0,
                                  decoration: BoxDecoration(
                                    color: alarm.WeekdayButtonColor[5],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "S",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // height: 100.0,
                                  decoration: BoxDecoration(
                                    color: alarm.WeekdayButtonColor[6],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //To show alarm time, edit and delete
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${alarm.alarmTimeToDisplay}',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white70,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                String text = alarm.description;
                                Vibrateok = alarm.VibrateON;
                                SelectedTimeInDateTimeFormat =
                                    alarm.alarmDateTime;
                                SelectedTimeInStringFormat =
                                    alarm.alarmTimeToDisplay;
                                Weekdays = alarm.ActiveWeekdays;
                                WeekdayButtonColor = alarm.WeekdayButtonColor;
                                ListIndex = alarm.AlarmNumber;
                                Append = false;
                                // Navigator.pop(context);
                                // Navigator.pushNamed(context, '/edit_alarm');
                                Get.off(EditAlarm());
                              }, ///////////////////////////////////////////////////////
                              icon: Icon(
                                Icons.edit,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                ListIndex = alarm.AlarmNumber;
                                // Navigator.pop(context);
                                // Navigator.pushNamed(
                                //     context, '/delete_alarm_popup');
                                Get.off(Delete_alert());
                              }, ///////////////////////////////////////////////////////
                              icon: Icon(
                                Icons.delete,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              label: Text(
                                "delete",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).followedBy([
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                  //   child: FlatButton(
                  //     padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                  //     onPressed: (){
                  //       ListIndex = allalarms[allalarms.length-1].AlarmNumber+1;
                  //       String text = '';
                  //       Vibrateok = false;
                  //       SelectedTimeInDateTimeFormat = TimeOfDay.now();
                  //       SelectedTimeInStringFormat ="";
                  //       Weekdays=[ false , false ,false ,false ,false ,false ,false ];
                  //       WeekdayButtonColor=[ Colors.white10 , Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white10 ];
                  //       Append = true;
                  //       Navigator.pop(context);
                  //       Navigator.pushNamed(context, '/edit_alarm');
                  //     },                                             ////////////////////////////////////////////////
                  //     child: Column(
                  //       children: [
                  //         Container(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Icon(
                  //                 Icons.add,
                  //                 size: 50,
                  //                 color: Colors.white24,
                  //               ),
                  //               Text(
                  //                 "Add",
                  //                 style: TextStyle(
                  //                   fontSize: 23,
                  //                   color: Colors.white24,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           padding: EdgeInsets.symmetric(vertical: 20),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   // height: 100.0,
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       // colors: [Color(0xFFFE6197) , Color(0xFF61A3FE)],
                  //       colors: [Color(0xFFFE6197) , Color(0xFF1E6197)],
                  //       // colors: [Color(0xFFCE6197) , Color(0xFF1E6197)],
                  //       // colors: [Color(0xFFFF8484) , Color(0xFF4E6197)],
                  //       begin: Alignment.centerLeft,
                  //       end: Alignment.centerRight,
                  //     ),
                  //     borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  //   ),
                  // ),
                ]).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
