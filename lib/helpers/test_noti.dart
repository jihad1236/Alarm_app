import 'package:alram_app/helpers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class testing_page extends StatefulWidget {
  const testing_page({super.key});

  @override
  State<testing_page> createState() => _testing_pageState();
}

class _testing_pageState extends State<testing_page> {
  @override
  @override
  Widget build(BuildContext context) {
    NotificationController notificationController = Get.put(
      NotificationController(),
    );

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            notificationController.showInstantNotification(
              id: 0,
              title: 'Hello!',
              body: 'This is an instant notification.',
            );
          },
          child: const Text("Show Instant Notification"),
        ),
      ),
    );
  }
}
