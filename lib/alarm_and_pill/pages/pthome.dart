import 'package:elcare_application/alarm_and_pill/Local_Notification/local_notification.dart';
import 'package:elcare_application/alarm_and_pill/Local_Notification/medicine_took_yes_no.dart';
import 'package:elcare_application/alarm_and_pill/pages/pt_add_medicine.dart';
import 'package:elcare_application/alarm_and_pill/pages/pt_handle_prescription.dart';
import 'package:elcare_application/alarm_and_pill/pages/pt_medicine_store.dart';
import 'package:elcare_application/alarm_and_pill/pages/pt_view_prescription.dart';
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';
import 'package:elcare_application/emergency_caller/emergency_caller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:alarm_manager/Local_Notification/local_notification.dart';
// import 'package:alarm_manager/Local_Notification/medicine_took_yes_no.dart';

class PTHome extends StatefulWidget {
  // const PTHome({Key? key}) : super(key: key);

  @override
  _PTHomeState createState() => _PTHomeState();
}

class _PTHomeState extends State<PTHome> {
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
      appBar: AppBar(
        title: const Text('Pill Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.grey[850],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EmergencyCaller()));
        },
        child: const Icon(Icons.call),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              // Text(
              //   "Pill Time",
              //   style: TextStyle(color: Colors.white, fontSize: 40),
              // ),
              SizedBox(height: 10),
              SizedBox.fromSize(
                size: Size(300, 100),
                child: RaisedButton(
                  elevation: 10.0,
                  color: Colors.purple.shade400.withOpacity(0.75), // background
                  textColor: Colors.white, // foreground
                  onPressed: () {
                    // Get.to(()=>HandlePrescription());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HandlePrescription()),
                    );
                    // Navigator.pushNamed(context,'/handle_prescription');
                  },
                  child: const Text(
                    'Add Prescriptions',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0),

              SizedBox.fromSize(
                size: Size(300, 100),
                child: RaisedButton(
                  //elevation: 10.0,
                  color: Colors.purple.shade400.withOpacity(0.75), // background
                  textColor: Colors.white, // foreground
                  onPressed: () {
                    // Get.to(()=>ViewPrescriptions());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPrescriptions()),
                    );
                    // Navigator.pushNamed(context,'/view_prescription',);
                  },
                  child: const Text(
                    'View Prescriptions',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0),

              SizedBox.fromSize(
                size: Size(300, 100),
                child: RaisedButton(
                  elevation: 10.0,
                  color: Colors.green.shade400.withOpacity(0.75), // background
                  textColor: Colors.white, // foreground
                  onPressed: () {
                    // Navigator.pushNamed(context,'/add_medicine');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMedicine()),
                    );
                  },
                  child: const Text(
                    'Add new medicine',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0),

              SizedBox.fromSize(
                size: const Size(300, 100),
                child: RaisedButton(
                  elevation: 10.0,
                
                  color: Colors.green.shade400.withOpacity(0.75), // background
                  textColor: Colors.white, // foreground
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PTMedicineStore()),
                    );
                    // Navigator.pushNamed(context,'/medicine');
                  },
                  child: const Text(
                    'View Medicine Store',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
