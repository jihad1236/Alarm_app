import 'package:alram_app/helpers/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart';

class testing_page extends StatefulWidget {
  const testing_page({super.key});

  @override
  State<testing_page> createState() => _testing_pageState();
}

class _testing_pageState extends State<testing_page> {
  @override
  void initState() {
    LocalNotificationService.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            LocalNotificationService.showInstantNotification(
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
