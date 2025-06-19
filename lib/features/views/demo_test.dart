import 'package:alram_app/features/views/notification_test.dart';
import 'package:flutter/material.dart';

class NotificationTestPage extends StatefulWidget {
  const NotificationTestPage({super.key});

  @override
  State<NotificationTestPage> createState() => _NotificationTestPageState();
}

class _NotificationTestPageState extends State<NotificationTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Test')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                NotificationService.showInstantNotification(
                  id: 1,
                  title: "Instant Alert",
                  body: "This is an instant notification",
                );
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text("Show Instant Notification"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                final scheduledTime = DateTime.now().add(
                  const Duration(seconds: 5),
                );
                NotificationService.scheduleNotification(
                  id: 2,
                  title: "Reminder",
                  body: "This is a scheduled notification",
                  scheduledTime: scheduledTime,
                );
              },
              icon: const Icon(Icons.alarm),
              label: const Text("Schedule Notification (5s later)"),
            ),
          ],
        ),
      ),
    );
  }
}
