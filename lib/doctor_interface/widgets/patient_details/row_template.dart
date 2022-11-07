
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';
import 'package:elcare_application/alarm_and_pill/services/PIllTakeInfo.dart';
import 'package:elcare_application/alarm_and_pill/services/Prescription.dart';
import 'package:elcare_application/doctor_interface/classes/patient.dart';
import 'package:elcare_application/doctor_user_menu.dart';
import 'package:flutter/material.dart';
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';

class Row_Template extends StatelessWidget {
 // final PatientDetails eachPatient;
  final PillTakeInfo eachpres;
//  final Medicine eachmed;

  const Row_Template({
    required this.eachpres,
//    required this.eachmed,
//    required this.eachPatient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
             color: Colors.black54,
            ),
        
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // color: Colors.grey[300],
              //border: Border.all(color: Colors.black),
              ),
              
            child: Text(eachpres.date, style: TextStyle(color: Colors.white),)
          ),
          SizedBox(
            width: 5.0,
          ),
          Container(

            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // color: Colors.grey[300],
              // border: Border.all(color: Colors.black),
              ),
            child: Text(eachpres.time,style: TextStyle(color: Colors.white),),
          ),
          SizedBox(
            width: 5.0,
          ),
        Container(
            padding: const EdgeInsets.all(10),
            // decoration: BoxDecoration(
              // color: Colors.grey[300],
              // border: Border.all(color: Colors.black),),
            child:Column(
              children: [
                for (Medicine i in eachpres.medicines! )
                  Text(i.name.toString() +"    "+ i.quantity.toString() ,style: TextStyle(color: Colors.white),),
              ],
            ),
          ),                              
          //  Text(eachpres.medList),
        ]));
  }
}