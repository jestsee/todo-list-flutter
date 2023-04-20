import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart';

import '../model/task.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init({bool initSchedule = false}) async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(settings);

    if (initSchedule) {
      initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      setLocalLocation(getLocation(locationName));
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
    _notifications.zonedSchedule(id, title, body,
        TZDateTime.from(scheduledDate, local), await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future scheduleTaskNotification(Task task) async {
    if (task.notificationId == null) {
      return;
    }
    await NotificationService.showScheduledNotification(
      id: task.notificationId!,
      title: task.title,
      body:
          'this task due ${DateFormat('dd MMMM yyyy - hh:mm').format(task.deadline!)}',
      scheduledDate: task.deadline!,
    );
  }

  static Future cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  static Future cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
}
