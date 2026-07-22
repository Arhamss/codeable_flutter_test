import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:codeable_flutter_test/core/notifications/firebase_notifications.dart';
import 'package:codeable_flutter_test/utils/helpers/logger_helper.dart';

class LocalNotificationService {
  factory LocalNotificationService() {
    return _instance;
  }

  LocalNotificationService._internal();

  static final LocalNotificationService _instance =
      LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int _notificationId = 0;

  Future<void> initializeLocalNotifications() async {
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const darwinInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  Future<void> _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final payload = notificationResponse.payload;
    if (payload == null) return;

    try {
      final decodedPayload = json.decode(payload) as Map<String, dynamic>;
      FirebaseNotificationService().navigationStreamController.add(
        decodedPayload,
      );
    } catch (e, s) {
      AppLogger.error('Error parsing notification payload', e, s);
    }
  }

  Future<void> sendLocalNotification(
    String? title,
    String? body,
    String payload,
  ) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'Default notification channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      id: _notificationId++,
      title: title ?? 'Notification',
      body: body ?? '',
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }
}
