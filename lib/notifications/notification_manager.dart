import 'package:bletest/main.dart';
import 'package:bletest/pages/journal_page/journal_screen.dart';
import 'package:bletest/settings/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager with ChangeNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationManager(SettingsManager manager) {
    debugPrint('Setting up notifications');
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) => handle(details));

    _setReflectionScheduledNotifications(manager.reflectionTime);
  }

  Future handle(NotificationResponse response) async {
    if (response.payload != null) {
      if (response.payload == 'reflection') {
        await navigatorKey.currentState
            ?.push(MaterialPageRoute(builder: (_) => const JournalScreen()));
      }
    }
  }

  void update(SettingsManager manager) {
    if (manager.allNotifications) {
      if (manager.journalNotifications) {
        _setReflectionScheduledNotifications(manager.reflectionTime);
      } else {
        flutterLocalNotificationsPlugin.cancel(111111);
      }
    } else {
      flutterLocalNotificationsPlugin.cancelAll();
    }
  }

  Future _setReflectionScheduledNotifications(TimeOfDay scheduleTime) async {
    tz.initializeTimeZones();
    DateTime time = DateTime.now();

    debugPrint(
        'scheduled reflection notification @ ${scheduleTime.hour}:${scheduleTime.minute}');

    await flutterLocalNotificationsPlugin.cancel(111111);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        111111,
        "Reflect on your day",
        "Click here to see",
        tz.TZDateTime.from(
            DateTime(time.year, time.month, time.day, scheduleTime.hour,
                scheduleTime.minute),
            tz.local),
        const NotificationDetails(
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
            ),
            android: AndroidNotificationDetails(
                'reflection', 'reflection_schedule')),
        androidAllowWhileIdle: true,
        payload: "reflection",
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
