import 'dart:math';
import 'dart:developer' as l;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import '../model/task.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init({bool initSchedule = false}) async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(settings);

    if (initSchedule) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            importance: Importance.max, icon: "@mipmap/ic_launcher"));
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    final date = scheduledDate.isUtc
        ? scheduledDate.toLocal().subtract(const Duration(hours: 7))
        : scheduledDate;
    if (date.isBefore(DateTime.now())) return;
    l.log('DATEE $date');
    _notifications.zonedSchedule(id, title, body,
        tz.TZDateTime.from(date, tz.local), await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future<int> scheduleTaskNotification(Task task) async {
    int? notificationId = task.notificationId;
    notificationId ??= Random().nextInt(999);
    await NotificationService.showScheduledNotification(
      id: notificationId,
      title: task.title,
      body:
          'this task due ${DateFormat('dd MMMM yyyy - hh:mm').format(task.deadline!)}',
      scheduledDate: task.deadline!.subtract(const Duration(minutes: 5)),
    );

    return notificationId;
  }

  static Future cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  static Future cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  static Future<List<PendingNotificationRequest>>
      pendingNotificationRequests() async {
    return await _notifications.pendingNotificationRequests();
  }
}
