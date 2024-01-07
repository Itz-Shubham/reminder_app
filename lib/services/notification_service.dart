import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const iOsInitializationSettings = DarwinInitializationSettings();
const androidInitializationSettings = AndroidInitializationSettings(
  '@mipmap/ic_launcher',
);
const initializationSettings = InitializationSettings(
  android: androidInitializationSettings,
  iOS: iOsInitializationSettings,
);

class NotificationService {
  static final _localNotification = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Task Alert',
        'Reminders',
        channelDescription: '',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future init() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    await _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _localNotification.initialize(initializationSettings);
  }

  static Future showNotification(String title) async {
    return _localNotification.show(
      0,
      title,
      '',
      await _notificationDetails(),
    );
  }

  static Future createNotification(
      int id, String title, String body, TimeOfDay time) async {
    return _localNotification.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(time.hour, time.minute),
      await _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> removeNotification(int id) async {
    return await _localNotification.cancel(id);
  }

  // static list() async {
  //   final list = await _localNotification.getActiveNotifications();
  //   print(list.map((e) => e.title));
  // }
}

tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
