import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:codeable_flutter_test/core/notifications/local_notification_service.dart';
import 'package:codeable_flutter_test/utils/helpers/logger_helper.dart';

class FirebaseNotificationService {
  factory FirebaseNotificationService() {
    return _instance;
  }

  FirebaseNotificationService._internal();

  static final FirebaseNotificationService _instance =
      FirebaseNotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final StreamController<Map<String, dynamic>> navigationStreamController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get navigationStream =>
      navigationStreamController.stream;

  Stream<String> get onTokenRefresh => _firebaseMessaging.onTokenRefresh;

  Future<String?> getFcmToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      AppLogger.info('FCM Token: $token');
      return token;
    } catch (e, s) {
      AppLogger.error('Error fetching FCM token', e, s);
      return null;
    }
  }

  Future<bool> deleteFCMToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      return true;
    } catch (e, s) {
      AppLogger.error('Error deleting FCM token', e, s);
      return false;
    }
  }

  Future<void> initialize() async {
    // iOS foreground presentation is intentionally left at SDK defaults
    // (all false). Enabling alert/badge/sound here makes iOS show its own
    // banner on top of the flutter_local_notifications one, duplicating the
    // notification.
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
  }

  Future<void> handleInitialMessage() async {
    final initial = await _firebaseMessaging.getInitialMessage();
    if (initial == null) return;
    navigationStreamController.add(initial.data);
  }

  Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    navigationStreamController.add(message.data);
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    AppLogger.info('Foreground message: ${message.data}');

    final notification = message.notification;
    if (notification != null) {
      await LocalNotificationService().sendLocalNotification(
        notification.title,
        notification.body,
        json.encode(message.data),
      );
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AppLogger.info('Background message: ${message.data}');
}
