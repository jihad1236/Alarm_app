import 'dart:io';
import 'package:alram_app/features/views/landing_page.dart';
import 'package:alram_app/features/views/location_page.dart';
import 'package:alram_app/features/views/testing_page.dart';
import 'package:alram_app/helpers/location_controller.dart';
import 'package:alram_app/helpers/notification_controller.dart';
import 'package:alram_app/helpers/test_noti.dart';
import 'package:alram_app/main.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationController notificationController = Get.put(
    NotificationController(),
  );
  notificationController.initNotification();
  notificationController.requestNotificationPermission();
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
