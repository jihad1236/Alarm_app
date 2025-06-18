import 'package:alram_app/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dummy alarm data with switch state
  List<Map<String, dynamic>> alarms = [
    {
      'time': TimeOfDay(hour: 19, minute: 10),
      'date': DateTime(2025, 3, 21),
      'enabled': true,
    },
    {
      'time': TimeOfDay(hour: 18, minute: 55),
      'date': DateTime(2025, 3, 28),
      'enabled': true,
    },
    {
      'time': TimeOfDay(hour: 19, minute: 00),
      'date': DateTime(2025, 4, 4),
      'enabled': true,
    },
  ];

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  String formatDate(DateTime date) {
    return DateFormat('EEE dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(''),
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
                  child: Text(
                    "79 Regent's Park Rd, London\nNW1 8UY, United Kingdom",
                    style: AppFonts.smallLabel,
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
                onPressed: () {
                  // TODO: Add alarm logic
                },
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
              child: ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final alarm = alarms[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Time
                        Text(
                          formatTime(alarm['time']),
                          style: AppFonts.headingLarge,
                        ),
                        const Spacer(),

                        // Date
                        Text(
                          formatDate(alarm['date']),
                          style: AppFonts.smallLabel,
                        ),
                        const SizedBox(width: 12),

                        // Switch
                        Switch(
                          value: alarm['enabled'],
                          onChanged: (value) {
                            setState(() {
                              alarms[index]['enabled'] = value;
                            });
                          },
                          activeColor: Colors.deepPurpleAccent,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
