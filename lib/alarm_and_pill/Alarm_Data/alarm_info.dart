import 'package:flutter/material.dart';


class AlarmInfo{


  TimeOfDay alarmDateTime = TimeOfDay.now();
  DateTime date=DateTime.now();
  int PrescriptionID=0;


  String alarmTimeToDisplay ='';
  String description="";
  bool isActive=false;
  List <bool> ActiveWeekdays=[];
  bool VibrateON=false;
  int AlarmNumber = 0;
  List <Color> WeekdayButtonColor = [];
  bool PilltimeOrDaily = true;
  AlarmInfo(TimeOfDay alarmDateTime, String alarmTimeToDisplay , DateTime date , String description , bool isActive , int AlarmNumber , List <bool> ActiveWeekdays , List <Color> WeekdayButtonColor ,bool VibrateON , bool PilltimeOrDaily, int PrescriptionID)
  {
    this.alarmDateTime = alarmDateTime;
    this.date = date;
    this.PrescriptionID = PrescriptionID;


    this.alarmTimeToDisplay =alarmTimeToDisplay;
    this.description = description;
    this.isActive = isActive;
    this.AlarmNumber = AlarmNumber;
    this.ActiveWeekdays = ActiveWeekdays;
    this.WeekdayButtonColor = WeekdayButtonColor;
    this.VibrateON=VibrateON;
    this.PilltimeOrDaily = PilltimeOrDaily;
  }

}

//////////////////////////////////////////////////////


List<AlarmInfo> allalarms = [
  AlarmInfo(TimeOfDay.now(), '8.00 PM' , DateTime.now() ,"Go to doctor" , false , 3 , [ false , false ,true ,false ,false ,false ,false ] , [ Colors.white10 , Colors.white10 ,Colors.white54 ,Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white10 ] , false , false,0),
  AlarmInfo(TimeOfDay.now(), '3.00 PM' , DateTime.now() ,"Sleep!!" , false , 4 , [ false , false ,false ,false ,true ,false ,false ] , [ Colors.white10 , Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white54 ,Colors.white10 ,Colors.white10 ] , false , false,0),
];

List<AlarmInfo> Pill_time_alarms = [
                                               /////////////////// ALARM LIST //////////////////////////////////
];

List<AlarmInfo> alarms = [
  AlarmInfo(TimeOfDay.now(), '8.00 PM' , DateTime.now() ,"Go to doctor" , false , 3 , [ false , false ,true ,false ,false ,false ,false ] , [ Colors.white10 , Colors.white10 ,Colors.white54 ,Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white10 ] , false , false,0),
  AlarmInfo(TimeOfDay.now(), '3.00 PM' , DateTime.now() ,"Sleep!!" , false , 4 , [ false , false ,false ,false ,true ,false ,false ] , [ Colors.white10 , Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white54 ,Colors.white10 ,Colors.white10 ] , false , false,0),
];




/////////////////////////////////////////////////////

bool Append=true; //true = appends , false = replaces
int ListIndex=3;

//edit alarm
String text = '';
bool Vibrateok = false;
TimeOfDay SelectedTimeInDateTimeFormat = TimeOfDay.now();
String SelectedTimeInStringFormat ="";
List <bool> Weekdays=[ false , false ,false ,false ,false ,false ,false ];
List <Color> WeekdayButtonColor=[ Colors.white10 , Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white10 ,Colors.white10 ];


var EnableColor  = Colors.white54;
var DisableColor = Colors.white10;

