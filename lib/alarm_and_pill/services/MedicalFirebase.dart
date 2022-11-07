import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elcare_application/alarm_and_pill/db/medi_database.dart';
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';

import 'package:elcare_application/alarm_and_pill/services/Prescription.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_output.dart';
import 'package:flutter/material.dart';

import 'PIllTakeInfo.dart';

class MedicalFirebase {
  static List<Prescription> prList = [];
//static List<PillTakeInfo> piList = [];

  static addMedicalDataToFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();

    prList = await AppDatabase.instance.readAllPrescriptions();
    var piList = await AppDatabase.instance.readAllPillTakeInfo();

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

    sharedPrefInit();

    String email = await getString("email");

    print("length is ${piList.length}");
    for (int i = 0; i < piList.length; i++) {
      var val = await FirebaseFirestore.instance
          .collection('users')
          .doc('$email')
          .collection("pill_take_info")
          .doc('${piList[i].id}')
          .set(piList[i].toJson());

      for (int j = 0; j < piList[i].medicines!.length; j++) {
        var val = await FirebaseFirestore.instance
            .collection('users')
            .doc('$email')
            .collection("medicines")
            .doc('${piList[i].medicines![j].id}')
            .set(piList[i].medicines![j].toJson());
      }
      print("anthima");
      print("Added to firebase");
    }
  }

  static Future<List<PillTakeInfo>> getMedicalInfoFromFirebase(String email) async {
    // print("fdsdfsdfs");
    // String email =
    //     await getString("email"); //////////////Patient email ekta danna
    // String password = await getString("password");

    var hell = await FirebaseFirestore.instance
        .collection("users")
        .doc('$email')
        .collection("pill_take_info")
        .get();
    var list = hell.docs.toList();
    var hell2 = await FirebaseFirestore.instance
        .collection("users")
        .doc('$email')
        .collection("medicines")
        .get();
    var list2 = hell2.docs.toList();

    List<PillTakeInfo> infoList = [];
    var medicines;

    List<Medicine> medicineList = [];

    print("medicine palleha");

    for (int i = 0; i < list2.length; i++) {
      int id = list2[i].get("_id");
      medicineList.add(Medicine(
        id: list2[i].get("_id"),
        name: list2[i].get('name'),
        quantity: list2[i].get('quantity'),
        prescription_id: list2[i].get('prescription_id'),
      ));
    }

    for (int i = 0; i < list.length; i++) {
      int id = list[i].get('prescription_id');
      print("parse");
      for (int j = 0; j < prList.length; j++) {
        if (id == prList[i].id) {
          medicines = prList[i].medicines;
        }
      }

      List<Medicine> selectedMedicine = [];
      for (int k = 0; k < medicineList.length; k++) {
        if (id == medicineList[i].prescription_id) {
          selectedMedicine.add(medicineList[i]);
        }
      }

      var p = PillTakeInfo(
        prescription_id: list[i].get('prescription_id'),
        date: list[i].get("date"),
        time: list[i].get("time"),
        id: list[i].get('_id'),
        medicines: selectedMedicine,
      );

      print("awa");
      infoList.add(p);
    }

    // for (var item in infoList) {
    //   print(item.date);
    //   // print(item.medicines![0].name);
    // }
    // print("Got from firebase");
    // print(infoList[0].date);
    return infoList;
  }
}
