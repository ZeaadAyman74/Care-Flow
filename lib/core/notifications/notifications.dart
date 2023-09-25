import 'dart:convert';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/fcm/fcm.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';

class NotificationsApi {
  final _notifications = FlutterLocalNotificationsPlugin();
  final onNotifications = BehaviorSubject<String?>();

  Future init() async {
    tz.initializeTimeZones();
    const androidInitialize = AndroidInitializationSettings('mipmap/ic_launcher');
    const iOSInitialize = DarwinInitializationSettings();
    const initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
          sl<FirebaseApi>().handleMessage(message);
          // onNotifications.add(details.payload);
        }
      },
    );
  }

  Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          playSound: true,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ));
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    await _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payLoad,
    );
  }

  Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleTime,
  }) async {
    _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleTime, tz.local),
        await _notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future dailyNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    // required DateTime scheduleTime,
  }) async {
    _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduleDaily(DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 43)),
        await _notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _scheduleDaily(DateTime time) {
    final now = tz.TZDateTime.now(tz.getLocation("Africa/Cairo"));
    final scheduledDate = tz.TZDateTime(tz.getLocation("Africa/Cairo"),
        now.year, now.month, now.day, time.hour, time.minute, time.second);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}
