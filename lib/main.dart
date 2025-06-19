import 'package:alram_app/features/views/landing_page.dart';
import 'package:alram_app/helpers/alarm_controller.dart';
import 'package:alram_app/helpers/location_controller.dart';
import 'package:alram_app/helpers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone for notifications
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Dhaka')); // Set your local timezone
  NotificationController notificationController = Get.put(
    NotificationController(),
  );
  notificationController.initNotification();
  notificationController.requestNotificationPermission();
  // Initialize controllers
  Get.put(AlarmController()); // Handles SQLite init internally
  Get.put(LocationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: OnboardingPage(),
    );
  }
}
