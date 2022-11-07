import 'package:elcare_application/alarm_and_pill/Local_Notification/local_notification.dart';
import 'package:flutter/material.dart';
import 'alarm_info.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
// import 'package:alarm_manager/Local_Notification/local_notification.dart';


AlarmInfo GET=AlarmInfo(TimeOfDay.now(), '', DateTime.now(), '', true, 0, [], [], true, true, 0);






int enable = 2;                   //not related
bool activate =true;              //not related


Pill_timer_alarm_Deactivate(int AlarmNumber)   /////////////////////////////////////////////////////////////////////////////////////////////
{
  AndroidAlarmManager.cancel(AlarmNumber);
}

//Function to add alarms through the database
ADDING_ALARM(TimeOfDay alarmDateTime  , int Year ,int Month , int Day, int? Perscription_id) {/////////////////////////////////////////////////////////////////////////

  DateTime date = DateTime.utc(Year,Month,Day);

  final difference = (date.year*525600+date.month*43800+date.day*60*24 + alarmDateTime.hour*60 + alarmDateTime.minute) - (DateTime.now().year*525600+DateTime.now().month*43800+DateTime.now().day*1440+TimeOfDay.now().hour*60+TimeOfDay.now().minute);


  if(difference>=0)
    {
      AlarmInfo temp = AlarmInfo(alarmDateTime , '' , date , '' , true , allalarms[allalarms.length-1].AlarmNumber+1 , [] , [] ,true , true , Perscription_id!);

      allalarms.add(temp);
      Pill_time_alarms.add(temp);

    }

}


PilltimeLoop()
{
  enable = 2;
  PillTimeTrigger();
  Timer(Duration(seconds: 120), PilltimeLoop);
}


PillTimeTrigger()
{
  for (int thisalarmindex=0;thisalarmindex<Pill_time_alarms.length;thisalarmindex++)
  {
    DateTime date = Pill_time_alarms[thisalarmindex].date;
    TimeOfDay alarmDateTime = Pill_time_alarms[thisalarmindex].alarmDateTime;
    final diff = (date.year*525600+date.month*43800+date.day*60*24 + alarmDateTime.hour*60 + alarmDateTime.minute) - (DateTime.now().year*525600+DateTime.now().month*43800+DateTime.now().day*1440+TimeOfDay.now().hour*60+TimeOfDay.now().minute);

          if(diff<2 && diff>=0 && Pill_time_alarms[thisalarmindex].isActive)
          {
            print("Triggered pilltimer alarm ${Pill_time_alarms[thisalarmindex].AlarmNumber}");
            GET = Pill_time_alarms[thisalarmindex];
            PillTimerAlarmTrigger(Pill_time_alarms[thisalarmindex].AlarmNumber);
          }
  }
}


PillTimerAlarmTrigger(int AlarmNumber)
{
  NotificationApi.showNotification(
    title: "Pill Time",
    body: "Hey, it's time for you to take medicine",
    payload: "now",
  );

  enable = 2;
  print("Activated pilltimer alarm ${AlarmNumber} at ${TimeOfDay.now()}");
  AndroidAlarmManager.oneShotAt(
    // date time format (year,month,date,hour,minutes,seconds)
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute ,0),
    AlarmNumber,
    PilltimerLoop,
  );

}


PilltimerLoop()
{


  enable-=1;
  if(enable>0)
  {
    print("Alarm activated");
    final player = AudioCache();
    player.play("notification.mp3");
    Timer(Duration(seconds: 5), PilltimerLoop);
  }
  else
    {
      enable=6;
    }
}









