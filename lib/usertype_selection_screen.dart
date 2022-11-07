

import 'package:elcare_application/controllers/login_controller.dart';
import 'package:elcare_application/doctor_user_menu.dart';
// import 'package:elcare_application/doctor_interfaces/screens/doctor_user_menu.dart';
import 'package:elcare_application/regular_user_menu.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSelection extends StatefulWidget {
  const UserSelection({Key? key}) : super(key: key);

  @override
  _UserSelectionState createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection> {
  static String? userType = '[Select Type]';
  LoginController? model;
  
  void mean() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User type',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(RegularUserMain());
                // sharedPrefInit();
                // putString("logged", "false");
                setState(() {
                  userType='Doctor';
                });
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30))),
              child: Container(
                height: 100,
                margin: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services_outlined,
                          size: 45,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Doctor',
                          style: TextStyle(fontSize: 20),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(()=>DoctorMenu());
                setState(() {
                  userType='Regular User';
                });
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal[700],
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30))),
              child: Container(
                height: 100,
                margin: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.supervised_user_circle_outlined,
                          size: 45,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Regular User',
                          style: TextStyle(fontSize: 20),
                        ),
                      ]),
                ),
              ),
            ),
            
            
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('I am a $userType',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      )),
                  Icon(Icons.navigate_next_outlined)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

