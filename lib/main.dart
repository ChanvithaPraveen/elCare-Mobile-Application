import 'dart:async';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:elcare_application/alarm_and_pill/Local_Notification/local_notification.dart';
import 'package:elcare_application/alarm_and_pill/db/medi_database.dart';
import 'package:elcare_application/alarm_and_pill/services/MediData.dart';
import 'package:elcare_application/alarm_and_pill/services/SetupPillTimerData.dart';
import 'package:elcare_application/controllers/login_controller.dart';
// import 'package:elcare_application/doctor_interfaces/screens/doctor_user_menu.dart';
import 'package:elcare_application/doctor_user_menu.dart';
import 'package:elcare_application/login_screen.dart';
import 'package:elcare_application/regular_user_menu.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_output.dart';
// import 'package:elcare_application/usertype_selection_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'alarm_and_pill/Alarm_Data/editable_lists.dart';
import 'alarm_and_pill/User_Set_Alarm_Run/trigger_alarms.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  WhileLoop();    //Should be inside the main file
  PilltimeLoop(); //Should be inside the main file

  Timer(Duration(seconds: 10),function);

  runApp(MyApp());

  SetupData.refreshAlarms();
  // SetupData.loadPillInfo();

  // runApp(MyApp());
  // var time = TimeOfDay(hour: 21, minute: 31);

  // ADDING_ALARM(time, 2021, 12, 3, 5);

  // var medi = MediData(
  //   description: "hello",
  //   name: "hello",
  //   quantity: 5
  // );

  //  medi = await AppDatabase.instance.addMediData(medi);
  //  print("medi id is ${medi.id}");
  
  
  // Initialize hive
  await Hive.initFlutter();
  // Open the Emergency Contact Box
  await Hive.openBox('emergencyContactBox');
  await Hive.openBox('sleepQualityBox');
  await Hive.openBox('sleepDurationBox');
  
  await Firebase.initializeApp();
  sharedPrefInit();
  var isLoggedIn = await getString("logged") == "true";
  print(isLoggedIn);
  print(await getString("userType"));
  var isDoctor = await getString("userType") == "Doctor";
  print("$isDoctor + $isLoggedIn");
  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        )
      ],
      child:
    GetMaterialApp(
    theme: ThemeData(fontFamily: 'Urbanist'),
    debugShowCheckedModeBanner: false,
    home:isLoggedIn ? (isDoctor?DoctorMenu():RegularUserMain()):LoginScreen(),
  )));

  await AndroidAlarmManager.initialize(); //Should be inside the main file
  SetupData.loadPillInfo();
  // runApp(MyApp());
}

class MyApp extends StatelessWidget  {
  // This widget is the root of your application.
  
  Future<bool> getIfLoggedIn() async{
    sharedPrefInit();
    var isLogin = await getString("logged")=="true";
    return isLogin == true ? true : false;
  }

  Future<bool> getIfDoctor() async{
    sharedPrefInit();
    var isDoctor = await getString("userType")=="Doctor";
    return isDoctor == true ? true : false;
  }

  
  @override
  Widget build(BuildContext context)  {
    
    
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        )
      ],
      child: MaterialApp (
        theme: ThemeData(fontFamily: 'Urbanist'),
        // home: LoginScreen(),
        // home: ((getString("logged")) == null ||
        //         (getString("logged")) == "false"
        //     ? LoginScreen()
        //     : (((getString("userType")) == "Doctor")
        //         ? UserSelection()
        //         : LoginScreen())),
        // home: (getIfADoctor() ? LoginScreen():UserSelection()),
        home:routeLogin(),
      ),
    );
  }

  routeLogin(){
    getIfLoggedIn().then((isLogin) => {
      if(isLogin){
        getIfDoctor().then((isDoctor)=>{
          if(isDoctor){
            MaterialPageRoute(builder: (context) => DoctorMenu())
          }else{
            MaterialPageRoute(builder: (context) => RegularUserMain())
          }
        })
        
        //return LoginScreen();
      }else{
        MaterialPageRoute(builder: (context) => LoginScreen())
      }
    });
  }
}




function()
{
  NotificationApi.showNotification(
    title: "Pill Time",
    body: "Hey, it's time for you to take medicine",
    payload: "now",
  );
}