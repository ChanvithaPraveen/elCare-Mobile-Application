// import 'package:alarm_manager/Alarm_Data/editable_lists.dart';
// import 'package:alarm_manager/db/medi_database.dart';
import 'dart:convert';
import 'dart:math';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elcare_application/alarm_and_pill/Alarm_Data/editable_lists.dart';
import 'package:elcare_application/alarm_and_pill/db/medi_database.dart';
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_output.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/User_Personal_Page/pill_take_info_firebase.dart';
import 'package:flutter/material.dart';

import 'PillTakeInfo.dart';
import 'Prescription.dart';

class SetupData {
  static List<Prescription> prList = [];
  static List<PillTakeInfo> piList = [];
  static Future<void> refreshAlarms() async {
    WidgetsFlutterBinding.ensureInitialized();
    prList = await AppDatabase.instance.readAllPrescriptions();
    //print("in main ${prList.length}");

    await AndroidAlarmManager.initialize();

//add the alarms

    for (int i = 0; i < prList.length; i++) {
      print("numOfdays:${prList[i].date}");
      var today = DateTime.now();
      var alarmTime = prList[i].time.replaceAll("AM", "");
      alarmTime = alarmTime.replaceAll("PM", "");

      //print("in main $alarmTime");
      int hr = int.parse(alarmTime.split(":")[0]);
      int min = int.parse(alarmTime.split(":")[1]);
      int year = int.parse(prList[i].date.split(" ")[0].split("-")[0]);
      int month = int.parse(prList[i].date.split(" ")[0].split("-")[1]);
      int day = int.parse(prList[i].date.split(" ")[0].split("-")[2]);
      print("year is $year");
      var alarmDate = DateTime(year, month, day, hr, min);
      var time = TimeOfDay(hour: hr, minute: min);

      if (prList[i].isAlarmOn) {
        for (int j = 0; j < prList[i].numOfDays; j++) {
          ADDING_ALARM(time, alarmDate.year, alarmDate.month, alarmDate.day,
              prList[i].id ?? 0);
          print("Alarm added at  ${alarmDate.toString()}");
          alarmDate = alarmDate.add(const Duration(days: 1));

          //ADDING_ALARM(time, alarmDate.year,alarmDate.month ,alarmDate.day);
        }
      }

      //5
    }
  }

  static Future<void> loadPillInfo() async {
    WidgetsFlutterBinding.ensureInitialized();
    piList = await AppDatabase.instance.readAllPillTakeInfo();
    prList = await AppDatabase.instance.readAllPrescriptions();

    for (int i = 0; i < piList.length; i++) {
      //add the medicines
      var presId = piList[i].prescription_id;
      for (int j = 0; j < prList.length; j++) {
        if (prList[j].id == presId) {
          piList[i] = piList[i].copy(medicines: prList[j].medicines);
          break;
        }
      }
    }
    //fff
    ///////////////////////////////////////////////////////////////////////////////////
//     print("fdsdfsdfs");
//     sharedPrefInit();
//     String email = await getString("email");
//     String password = await getString("password");
//     String docemail = await getString("docemail");
//     String name = await getString("name");

// // await FirebaseFirestore
// //     .instance
// //     .collection('users')
// //     .doc('ghjh@mm.com')
// //     .collection(
// //         "lk")
// //     .add({
// //       "scsdf":"sdfsdf",
// //       "efwe":"rrwe"
// //     });

//     print("length is ${piList.length}");
//     for (int i = 0; i < piList.length; i++) {
//       var val = await FirebaseFirestore.instance
//           .collection('users')
//           .doc('$email')
//           .collection("pill_take_info")
//           .doc('${piList[i].id}')
//           .set(piList[i].toJson());

//       for (int j = 0; j < piList[i].medicines!.length; j++) {
//         var val = await FirebaseFirestore.instance
//             .collection('users')
//             .doc('$email')
//             .collection("medicines")
//             .doc('${piList[i].medicines![j].id}')
//             .set(piList[i].medicines![j].toJson());
//       }
//       print("anthima");
//     }

//     var hell = await FirebaseFirestore.instance
//         .collection("users")
//         .doc('$email')
//         .collection("pill_take_info")
//         .get();
//     var list = hell.docs.toList();
//     var hell2 = await FirebaseFirestore.instance
//         .collection("users")
//         .doc('$email')
//         .collection("medicines")
//         .get();
//     var list2 = hell2.docs.toList();

//     List<PillTakeInfo> infoList = [];
//     var medicines;

//     List<Medicine> medicineList = [];

//     print("medicine palleha");

//     for (int i = 0; i < list2.length; i++) {
//       int id = list2[i].get("_id");
//       medicineList.add(Medicine(
//         id: list2[i].get("_id"),
//         name: list2[i].get('name'),
//         quantity: list2[i].get('quantity'),
//         prescription_id: list2[i].get('prescription_id'),
//       ));
//     }

//     for (int i = 0; i < list.length; i++) {
//       int id = list[i].get('prescription_id');
//       print("parse");
//       for (int j = 0; j < prList.length; j++) {
//         if (id == prList[i].id) {
//           medicines = prList[i].medicines;
//         }
//       }

//       List<Medicine> selectedMedicine = [];
//       for(int k = 0; k<medicineList.length; k++){
//         if(id == medicineList[i].prescription_id){
//           selectedMedicine.add(medicineList[i]);
//         }
//       }

//       var p = PillTakeInfo(
//         prescription_id: list[i].get('prescription_id'),
//         date: list[i].get("date"),
//         time: list[i].get("time"),
//         id: list[i].get('_id'),
//         medicines: selectedMedicine,
//       );

//       print("awa");
//       infoList.add(p);
//     }

//     for (var item in infoList) {
//       print(item.date);
//       print(item.medicines![0].name);
//     }

// // static Prescription fromJson(Map<String, Object?> json) => Prescription(
// //     id: json[PressFields.id] as int?,
// //     time: json[PressFields.time] as String,
// //     isAlarmOn: json[PressFields.isAlarmOn] == 1,
// //     date: json[PressFields.date] as String,
// //     numOfDays: json[PressFields.numOfDays] as int,
// //   );

// // for(int i=0; i<piList.length;i++){
// //   await FirebaseFirestore
// //     .instance
// //     .collection('users')
// //     .doc('ghjh@mm.com')
// //     .collection(
// //         "pill_take_info")
// //     .add({"name":"name"});
// // }
//     ///////////////////////////////////////////////////////////////////////////////////

    // for (int i = 0; i < piList.length; i++) {
    //   print(piList[i].medicines);
    // }
  }
}
