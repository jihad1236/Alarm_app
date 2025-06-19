import 'dart:io';
import 'package:alram_app/features/views/landing_page.dart';
import 'package:alram_app/features/views/location_page.dart';
import 'package:alram_app/features/views/testing_page.dart';
import 'package:alram_app/helpers/location_service.dart';
import 'package:alram_app/helpers/notification_services.dart';
import 'package:alram_app/helpers/test_noti.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestNotificationPermission();
  await LocalNotificationService.init();

  Get.put(LocationController());
  runApp(const MyApp());
}

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    if (androidInfo.version.sdkInt >= 33) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }
  }
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
      home: testing_page(),
    );
  }
}
