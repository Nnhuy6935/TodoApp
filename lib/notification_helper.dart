import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationHelper{
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // static final onClickNotification = BehaviorSubject<String>();
  //INITIALIZE THE LOCAL NOTIFICATION
  static Future init() async{
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          onDidReceiveLocalNotification: (id,title, body, payload) => null,
        );
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
        
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (detail) => null,
    );

  }

  //show a simple notification 
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails,
        payload: payload);
  }

  // show periodic notification 
  static Future showPeriodicNotification({
    required String title,
    required String body,
    required String payload,
  }) async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('Channel 2', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(1, title, body,
      RepeatInterval.everyMinute, 
      notificationDetails);
  }

  // schedule notification 
  static Future showScheduledNotification({
    required String title,
    required String body,
    required String payload,
  }) async{
    tz.initializeTimeZones();
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "Channel 3", 
        "my channel 3",
        channelDescription: 'my channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
    );
    print(tz.TZDateTime.now(tz.local));
    await _flutterLocalNotificationsPlugin.zonedSchedule(2, title, body, 
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), 
      notificationDetails, 
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,  
    );
  }

  // cancel a notification 
  static Future cancelNotification(int id) async{
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // cancel all notification
  static Future cancelAllNotification() async{
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

}