// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi{
  static final _notification = FlutterLocalNotificationsPlugin();
  // static final onNotifications = BehaviorSubject<String?>();
  static final onNotifications = BehaviorSubject<String>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        // 'channel description',
        importance: Importance.high,
      )
    );
  }

static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);

    await _notification.initialize(
      settings,
      onSelectNotification: (payload) async{
        onNotifications.add(payload);

      },
    );
  }


  static Future showNotification({


    int id = 0,
    String title,
    String body,
    String payload,
}) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

}

//   }
//
//   Future notificationSelected(String payload){
//
//   }
// }