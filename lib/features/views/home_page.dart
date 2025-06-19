import 'package:alram_app/constants/fonts.dart';
import 'package:alram_app/helpers/alarm_controller.dart';
import 'package:alram_app/helpers/location_controller.dart';
import 'package:alram_app/helpers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final locationController = Get.put(LocationController());
  final notificationController = Get.put(NotificationController());
  final alarmController = Get.put(AlarmController());

  String formatDate(DateTime date) {
    return DateFormat('EEE dd MMM yyyy').format(date);
  }

  String formatTime(DateTime date) {
    return DateFormat.jm().format(date);
  }

  Future<void> pickDateTime() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    final scheduledDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Save alarm to SQLite
    await alarmController.addAlarm(
      DateFormat.jm().format(scheduledDateTime),
      scheduledDateTime
          .toIso8601String(), // use ISO string to avoid parse errors
    );

    // Schedule local notification
    notificationController.shedule_alarm(
      DateTime.now().millisecondsSinceEpoch.remainder(100000), // unique ID
      'Alarm',
      'It\'s time!',
      scheduledDateTime,
    );
  }

  @override
  void initState() {
    super.initState();
    alarmController.loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selected Location", style: AppFonts.headingMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Iconsax.location, size: 18, color: Colors.white70),
                const SizedBox(width: 6),
                Expanded(
                  child: Obx(
                    () => Text(
                      locationController.address.value,
                      style: AppFonts.smallLabel,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Add Alarm Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: pickDateTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white12,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Add Alarm"),
              ),
            ),
            const SizedBox(height: 24),

            // Alarm List Title
            const Text("Alarms", style: AppFonts.headingMedium),
            const SizedBox(height: 12),

            // Alarm List
            Expanded(
              child: Obx(() {
                final alarms = alarmController.alarms;
                if (alarms.isEmpty) {
                  return const Center(
                    child: Text(
                      "No alarms set.",
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: alarms.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final alarm = alarms[index];
                    final time = alarm['time'];
                    final date = alarm['date'];
                    final isEnabled = alarm['enabled'] == 1;
                    final alarmId = alarm['id'];

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(time, style: AppFonts.headingLarge),
                          const Spacer(),
                          Text(
                            formatDate(DateTime.parse(date)),
                            style: AppFonts.smallLabel,
                          ),
                          const SizedBox(width: 12),
                          Switch(
                            value: isEnabled,
                            onChanged: (value) {
                              alarmController.toggleAlarm(alarmId, value);
                            },
                            activeColor: Colors.deepPurpleAccent,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
