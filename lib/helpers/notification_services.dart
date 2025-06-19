import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static Future init() async {
    // Create an instance of the notifications plugin
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // 🔸 Android Initialization: Provide an icon from android/app/src/main/res/drawable
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        ); // 'app_icon' must exist in drawable folder

    // 🔸 iOS/macOS Initialization: Uses Darwin (previously iOS) settings
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    // 🔸 Linux Initialization: Optional config for Linux desktop support
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(
          defaultActionName: 'Open notification', // text when clicked
        );

    // 🔸 Windows Initialization: Optional config for Windows desktop support
    final WindowsInitializationSettings
    initializationSettingsWindows = WindowsInitializationSettings(
      appName: 'Flutter Local Notifications Example', // your app name
      appUserModelId:
          'Com.Dexterous.FlutterLocalNotificationsExample', // unique ID
      guid:
          'd49b0314-ee7a-4626-bf79-97cdb8a991bb', // generate your own GUID if needed
    );

    // 🔸 Combine all platforms into InitializationSettings
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: initializationSettingsDarwin,
          linux: initializationSettingsLinux,
          windows: initializationSettingsWindows,
        );

    // 🔊 Create custom channel with sound
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'custom_sound_channel',
      'Custom Sound Channel',
      description: 'Channel for custom sound',
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // 🔸 Initialize the plugin with settings and optional notification tap handler
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // 🔹 Optional callback when user taps the notification
        null;
      },
    );
  }

  /// ✅ Show an instant notification
  static Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'custom_sound_channel', // must match exactly
          'Custom Sound Channel',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification_sound'),
        );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await FlutterLocalNotificationsPlugin().show(
      id,
      title,
      body,
      notificationDetails,
    );
  }
}
