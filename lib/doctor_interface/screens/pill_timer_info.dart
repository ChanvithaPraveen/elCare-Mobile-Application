
import 'package:elcare_application/doctor_user_menu.dart';
import 'package:elcare_application/doctor_interface/widgets/patient_details/row_template.dart';
import 'package:flutter/material.dart';


class PillTimerInfo extends StatelessWidget {
  final eachPatient;

  const PillTimerInfo({
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
          'Pill Timer Details',
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
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
          child: ListView.builder(
              itemCount: presList.length,
              itemBuilder: (context, index) {
                return Row_Template(
           //       eachPatient: patient[index],
                  eachpres: presList[index],
           //       eachmed: medList[index],
                );
              })),
    );
  }
}