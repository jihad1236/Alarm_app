import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationController extends GetxController {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void onInit() {
    super.onInit();
    initNotification();
  }

  /// 🔔 Initialize notifications and create channel
  Future<void> initNotification() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS/Mac
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    // Full platform settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: initializationSettingsDarwin,
        );

    // Create notification channel (Android)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'custom_sound_channel',
      'Custom Sound Channel',
      description: 'Channel for custom sound',
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    // Register channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Initialize plugin
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Optional tap handler
      },
    );

    // 🔐 Request permission
    await requestNotificationPermission();
  }

  /// 📢 Show instant notification
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'custom_sound_channel',
          'Custom Sound Channel',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification_sound'),
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  // /// ⏰ Schedule a notification (example: 5 seconds later)
  // Future<void> scheduleNotification({
  //   required int id,
  //   required String title,
  //   required String body,
  //   required DateTime scheduledTime,
  // }) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     tz.TZDateTime.from(scheduledTime, tz.local),
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'custom_sound_channel',
  //         'Custom Sound Channel',
  //         playSound: true,
  //         importance: Importance.high,
  //         priority: Priority.high,
  //         sound: RawResourceAndroidNotificationSound('notification_sound'),
  //       ),
  //     ),
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

  /// ✅ Ask for notification permission
  Future<void> requestNotificationPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await Permission.notification.status;
      if (androidInfo.isDenied || androidInfo.isRestricted) {
        await Permission.notification.request();
      }
    }
  }
}
