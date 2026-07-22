import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:codeable_flutter_test/core/api_service/api_service.dart';
import 'package:codeable_flutter_test/core/app_preferences/app_preferences.dart';
import 'package:codeable_flutter_test/core/permissions/permission_manager.dart';
import 'package:codeable_flutter_test/core/socket_service/socket_service.dart';
// import 'package:codeable_flutter_test/core/notifications/firebase_notifications.dart';
// import 'package:codeable_flutter_test/core/notifications/local_notification_service.dart';

abstract class AppModule {
  static late final GetIt _container;

  static Future<void> setup(GetIt container) async {
    _container = container;
    await _setupHive();
    await _setupAppPreferences();
    await _setupAPIService();
    await _setupPermissionManager();
    _setupSocketService();
    // await _setupNotifications();
  }

  static Future<void> _setupHive() async {
    await Hive.initFlutter();
    // Register Hive adapters here
    // Hive.registerAdapter(YourModelAdapter());
  }

  static Future<void> _setupAPIService() async {
    final apiService = ApiService();
    _container.registerSingleton<ApiService>(apiService);
  }

  static Future<void> _setupAppPreferences() async {
    final appPreferences = AppPreferences();
    await appPreferences.init('app-storage');
    _container.registerSingleton<AppPreferences>(appPreferences);
  }

  static Future<void> _setupPermissionManager() async {
    final permissionManager = PermissionManager();
    _container.registerSingleton<PermissionManager>(permissionManager);
  }

  static void _setupSocketService() {
    final socketService = SocketService(
      appPreferences: _container<AppPreferences>(),
    );
    _container.registerSingleton<SocketService>(socketService);
  }

  // Uncomment when Firebase is configured
  // static Future<void> _setupNotifications() async {
  //   final firebaseNotifications = FirebaseNotifications();
  //   _container.registerSingleton<FirebaseNotifications>(firebaseNotifications);
  //   final localNotificationService = LocalNotificationService();
  //   await localNotificationService.init();
  //   _container.registerSingleton<LocalNotificationService>(localNotificationService);
  // }
}
