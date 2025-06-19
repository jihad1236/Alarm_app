import 'package:alram_app/constants/app_colors.dart';
import 'package:alram_app/constants/fonts.dart';
import 'package:alram_app/features/views/home_page.dart';
import 'package:alram_app/helpers/location_controller.dart';
import 'package:alram_app/helpers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(
      LocationController(),
    ); // inject controller
    final notificationController = Get.put(NotificationController());
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.04),

              // Title
              Text(
                "Welcome! Your\nPersonalized Alarm",
                textAlign: TextAlign.center,
                style: AppFonts.headingLarge,
              ),

              SizedBox(height: height * 0.02),

              // Subtitle
              Text(
                "Allow us to sync your sunset alarm\nbased on your location.",
                textAlign: TextAlign.center,
                style: AppFonts.smallLabel,
              ),

              SizedBox(height: height * 0.05),

              // Circle Image
              ClipOval(
                child: Image.asset(
                  'assets/images/page4.png',
                  width: width * 0.75,
                  height: width * 0.75,
                  fit: BoxFit.cover,
                ),
              ),

              const Spacer(),

              // Use Current Location button
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // ✅ Wait for permission and location fetch
                    await locationController.getPermissionAndLocation();

                    // ✅ Show notification only if permission granted and address is fetched
                    if (locationController.isgaranted.value &&
                        locationController.address.value.isNotEmpty) {
                      await notificationController.showInstantNotification(
                        id: 1,
                        title: "My Current Location",
                        body: locationController.address.value,
                      );
                    }

                    // ✅ Navigate to next screen regardless
                    Get.to(const HomePage());
                  },

                  icon: Icon(Iconsax.location, size: width * 0.06),
                  label: Text("Use Current Location", style: AppFonts.button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              Obx(
                () => Text(
                  locationController.address.value,
                  style: AppFonts.smallLabel,
                ),
              ),
              SizedBox(height: height * 0.015),

              // Home button
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const HomePage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Home", style: AppFonts.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
