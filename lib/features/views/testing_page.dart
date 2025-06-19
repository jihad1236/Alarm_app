import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  String locationMessage = "Press button to get location";
  String address = "No address yet";

  Future<void> _getPermissionAndLocation() async {
    try {
      final status = await Permission.location.request();
      if (!status.isGranted) {
        setState(() {
          locationMessage = "Location permission denied.";
        });
        return;
      }

      // ✅ Get current position
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        locationMessage =
            "Lat: ${position.latitude}, Long: ${position.longitude}";
      });

      // ✅ Convert to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          address =
              "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        locationMessage = "Error: ${e.toString()}";

        print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror :$e");
        address = "Unable to get address.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("My Location")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _getPermissionAndLocation,
              icon: const Icon(Icons.my_location),
              label: const Text("Get My Location"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 30),
            Text(locationMessage, style: TextStyle(fontSize: width * 0.045)),
            const SizedBox(height: 20),
            Text(
              address,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
