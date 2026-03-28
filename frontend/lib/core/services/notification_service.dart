// lib/core/services/notification_service.dart
// Waketale v2 — Local notification scheduling with timezone support.
// Uses flutter_local_notifications ^21.0.0 (all-named-parameter API).
// Handles: bedtime reminder, morning check-in reminder, weekly progress report.

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../l10n/app_strings.dart';

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ── Notification IDs ────────────────────────────────────────────────────────
  static const int _idBedtime = 1001;
  static const int _idCheckin = 1002;
  static const int _idWeekly  = 1003;

  // ── Channel ID (stable, never translated) ───────────────────────────────────
  static const String _channelId = 'waketale_reminders';

  // ── Initialization ───────────────────────────────────────────────────────────

  static Future<void> init(S s) async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings: initSettings);

    // Create Android notification channel with localized name/description
    final androidChannel = AndroidNotificationChannel(
      _channelId,
      s.notifChannelName,
      description: s.notifChannelDesc,
      importance: Importance.high,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  // ── Notification details ─────────────────────────────────────────────────────

  static AndroidNotificationDetails _androidDetails(S s) =>
      AndroidNotificationDetails(
        _channelId,
        s.notifChannelName,
        channelDescription: s.notifChannelDesc,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
      );

  static DarwinNotificationDetails get _iosDetails =>
      const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

  static NotificationDetails _notifDetails(S s) => NotificationDetails(
        android: _androidDetails(s),
        iOS: _iosDetails,
      );

  // ── Scheduling helpers ───────────────────────────────────────────────────────

  /// Returns the next [tz.TZDateTime] for the given [time] (today or tomorrow).
  static tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// Returns the next Sunday at the given [time].
  static tz.TZDateTime _nextSunday(TimeOfDay time) {
    var scheduled = _nextInstanceOfTime(time);
    while (scheduled.weekday != DateTime.sunday) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  // ── Public API ───────────────────────────────────────────────────────────────

  /// Schedule a daily bedtime reminder 30 minutes before [bedtime].
  static Future<void> scheduleBedtimeReminder(TimeOfDay bedtime, S s) async {
    final totalMinutes = bedtime.hour * 60 + bedtime.minute - 30;
    final reminderTime = TimeOfDay(
      hour: (totalMinutes ~/ 60) % 24,
      minute: totalMinutes % 60,
    );
    final scheduled = _nextInstanceOfTime(reminderTime);

    await _plugin.zonedSchedule(
      id: _idBedtime,
      title: s.notifBedtimeTitle,
      body: s.notifBedtimeBody,
      scheduledDate: scheduled,
      notificationDetails: _notifDetails(s),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedule a daily morning check-in reminder at [wakeTime].
  static Future<void> scheduleCheckinReminder(TimeOfDay wakeTime, S s) async {
    final scheduled = _nextInstanceOfTime(wakeTime);

    await _plugin.zonedSchedule(
      id: _idCheckin,
      title: s.notifCheckinTitle,
      body: s.notifCheckinBody,
      scheduledDate: scheduled,
      notificationDetails: _notifDetails(s),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedule a weekly progress report every Sunday at 9:00 AM.
  static Future<void> scheduleWeeklyReport(S s) async {
    const sundayNineAm = TimeOfDay(hour: 9, minute: 0);
    final scheduled = _nextSunday(sundayNineAm);

    await _plugin.zonedSchedule(
      id: _idWeekly,
      title: s.notifWeeklyTitle,
      body: s.notifWeeklyBody,
      scheduledDate: scheduled,
      notificationDetails: _notifDetails(s),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  /// Cancel the bedtime reminder.
  static Future<void> cancelBedtimeReminder() async {
    await _plugin.cancel(id: _idBedtime);
  }

  /// Cancel the morning check-in reminder.
  static Future<void> cancelCheckinReminder() async {
    await _plugin.cancel(id: _idCheckin);
  }

  /// Cancel the weekly progress report.
  static Future<void> cancelWeeklyReport() async {
    await _plugin.cancel(id: _idWeekly);
  }

  /// Cancel all scheduled notifications.
  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
