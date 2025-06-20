// ignore_for_file: deprecated_member_use

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocationController extends GetxController {
  RxString locationMessage = "Press button to get location".obs;
  RxString address = "No address yet".obs;
  RxBool isgaranted = false.obs;

  Future<void> getPermissionAndLocation() async {
    try {
      final status = await Permission.location.request();

      if (!status.isGranted) {
        locationMessage.value = "Location permission denied.";
        return;
      }

      // ✅ Get coordinates
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      locationMessage.value =
          "Lat: ${position.latitude}, Long: ${position.longitude}";

      // ✅ Convert to address
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address.value =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
      isgaranted = true.obs;
    } catch (e) {
      locationMessage.value = "Error: ${e.toString()}";
      address.value = "Unable to get address.";
    }
  }

  Future<void> initializeTimezoneFromDevice() async {
    try {
      // Get timezone name from device
      final String timezoneName = await FlutterTimezone.getLocalTimezone();

      print("🕒 Detected Timezone: $timezoneName");

      // Initialize timezone package and set local location
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } catch (e) {
      print("❌ Failed to get timezone: $e");
      rethrow;
    }
  }
}
