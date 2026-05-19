import 'dart:io';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../l10n/app_localizations.dart';
import '../../features/pregnancy/domain/pregnancy_settings.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // Ensure this icon exists or use a default one

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tapped logic
      },
    );

    _isInitialized = true;
  }

  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      final bool? result = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return result ?? false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();

      final bool? grantedExactAlarmPermission =
          await androidImplementation?.requestExactAlarmsPermission();

      return (grantedNotificationPermission ?? false) &&
          (grantedExactAlarmPermission ?? false);
    }
    return false;
  }

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'elpis_main_channel',
      'Elpis Notifications',
      channelDescription: 'Main channel for Elpis notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: platformDetails,
      payload: payload,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }

  AppLocalizations _l10nFor(String languageCode) {
    final normalized = languageCode.contains('_')
        ? languageCode.split('_').first
        : languageCode.contains('-')
            ? languageCode.split('-').first
            : languageCode;
    return lookupAppLocalizations(Locale(normalized.toLowerCase()));
  }

  /// Schedules pregnancy milestone notifications for each upcoming week.
  Future<void> schedulePregnancyUpdates(PregnancySettings settings) async {
    // First cancel all existing weekly notifications
    for (int i = 1; i <= 42; i++) {
      await cancelNotification(100 + i);
    }

    if (!settings.notifyWeekly) return;

    final now = DateTime.now();
    final conceptionDate =
        settings.estimatedDueDate.subtract(const Duration(days: 280));
    final currentWeek = (now.difference(conceptionDate).inDays / 7).floor() + 1;

    final l10n = _l10nFor(settings.languageCode);
    final momName = settings.momName != null && settings.momName!.isNotEmpty
        ? settings.momName!
        : '';
    final babyName = settings.babyName != null && settings.babyName!.isNotEmpty
        ? settings.babyName!
        : '';

    for (int week = currentWeek; week <= 42; week++) {
      final weekStartDate = conceptionDate.add(Duration(days: (week - 1) * 7));

      var scheduledDate = DateTime(
        weekStartDate.year,
        weekStartDate.month,
        weekStartDate.day,
        10,
        0,
        0,
      );

      if (scheduledDate.isBefore(now)) continue;

      await _notificationsPlugin.zonedSchedule(
        id: 100 + week,
        title: momName.isNotEmpty
            ? l10n.notificationWeeklyTitleNamed(momName)
            : l10n.notificationWeeklyTitle,
        body: l10n.notificationWeeklyBody(
          week,
          babyName.isNotEmpty ? babyName : l10n.notificationBabyFallback,
        ),
        scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'elpis_weekly_channel',
            'Elpis Weekly Updates',
            channelDescription: 'Notifications for pregnancy weekly updates',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  /// Schedules daily habit reminders (Vitamins and Water)
  Future<void> scheduleDailyHabits(PregnancySettings settings) async {
    await cancelNotification(10);
    await cancelNotification(11);

    final l10n = _l10nFor(settings.languageCode);
    final momName = settings.momName != null && settings.momName!.isNotEmpty
        ? settings.momName!
        : '';

    if (settings.notifyVitamins) {
      await _scheduleDailyAt(
        id: 10,
        hour: 9,
        minute: 0,
        title: momName.isNotEmpty
            ? l10n.notificationVitaminsTitleNamed(momName)
            : l10n.notificationVitaminsTitle,
        body: l10n.notificationVitaminsBody,
      );
    }

    if (settings.notifyWater) {
      await _scheduleDailyAt(
        id: 11,
        hour: 18,
        minute: 0,
        title: momName.isNotEmpty
            ? l10n.notificationWaterTitleNamed(momName)
            : l10n.notificationWaterTitle,
        body: l10n.notificationWaterBody,
      );
    }
  }

  Future<void> _scheduleDailyAt({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'elpis_daily_habits',
          'Elpis Daily Habits',
          channelDescription: 'Daily reminders for water and vitamins',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents:
          DateTimeComponents.time, // Repeats daily at this time
    );
  }
}
