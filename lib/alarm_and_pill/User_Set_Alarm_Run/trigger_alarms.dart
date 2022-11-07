import 'package:flutter/material.dart';
import '../Alarm_Data/alarm_info.dart';
import 'dart:async';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:audioplayers/audioplayers.dart';


int enabl = 2;


WhileLoop()
{
  Trigger_all();
  Timer(Duration(seconds: 120), WhileLoop);
}


Trigger_all()
{
  for (int thisalarmindex=0;thisalarmindex<alarms.length;thisalarmindex++)
  {
    for (int weekday=0;weekday<7;weekday++)
    {
      if(alarms[thisalarmindex].ActiveWeekdays[weekday]==true)
      {
        if((weekday+1 -DateTime.now().weekday)>=0 && (weekday+1 -DateTime.now().weekday)<1 )
        {
          final nowtime = TimeOfDay.now();
          final alarmtime= alarms[thisalarmindex].alarmDateTime;
          final diff = (alarmtime.hour*60+alarmtime.minute) - (nowtime.hour*60+nowtime.minute);
          if(diff<2 && diff>=0 && alarms[thisalarmindex].isActive)
          {
            print("Triggered ${alarms[thisalarmindex].AlarmNumber}");
            User_set_Activate_Alarm(alarms[thisalarmindex].AlarmNumber);
          }
        }
      }
    }
  }
}


User_set_Activate_Alarm(int AlarmNumber)
{
  enabl = 2;
  print("Activated");
  AndroidAlarmManager.oneShotAt(
    // date time format (year,month,date,hour,minutes,seconds)
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute ,0),
    AlarmNumber,
    User_set_Alarm,
  );

}



User_set_Alarm() {
  print('Alarm Fired at ${DateTime.now()}');
  AlarmLoop();
}


AlarmLoop()
{
  final player = AudioCache();
  player.play("alarm_sound.mp3");
  enabl-=1;
  if(enabl>0)
    {
      Timer(Duration(seconds: 10), AlarmLoop);
    }
}



User_set_Deactivate_Alarm(int AlarmNumber)
{
  AndroidAlarmManager.cancel(AlarmNumber);
  print('Alarm Timer Canceled');
}



