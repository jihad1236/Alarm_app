import 'package:alram_app/constants/app_colors.dart';

import 'package:alram_app/constants/fonts.dart';
import 'package:alram_app/features/views/location_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Widget> onboardingScreens = [
    const OnboardItem(
      gifPath: 'assets/images/page1.gif',
      title: "Sync with Nature’s\nRhythm",
      description:
          "Experience a peaceful transition into the evening\nwith an alarm that aligns with the sunset.*\nYour perfect reminder, always 15 minutes before\nsundown",
    ),
    const OnboardItem(
      gifPath: 'assets/images/page2.gif',
      title: "Effortless & Automatic",
      description:
          "No need to set alarms manually. Wakey calculates the sunset time for your location and alerts you on time.",
    ),
    const OnboardItem(
      gifPath: 'assets/images/page3.gif',
      title: "Relax & Unwind",
      description: "hope to take the courage to pursue your dreams.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingScreens.length,
                onPageChanged: (index) => setState(() => currentPage = index),
                itemBuilder: (_, index) => onboardingScreens[index],
              ),
            ),

            // Dots + Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingScreens.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentPage == index ? 10 : 8,
                        height: currentPage == index ? 10 : 8,
                        decoration: BoxDecoration(
                          color:
                              currentPage == index
                                  ? AppColors.white
                                  : AppColors.white70,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentPage == onboardingScreens.length - 1) {
                          Get.to(const LocationPage());
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        currentPage == onboardingScreens.length - 1
                            ? "Get Started"
                            : "Next",
                        style: AppFonts.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardItem extends StatelessWidget {
  final String gifPath;
  final String title;
  final String description;

  const OnboardItem({
    super.key,
    required this.gifPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // GIF image
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  child: Image.asset(gifPath, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 16,
                right: 20,
                child: TextButton(
                  onPressed: () {
                    Get.to(const LocationPage());
                  },
                  child: Text('Skip', style: AppFonts.button),
                ),
              ),
            ],
          ),
        ),

        // Texts
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(title, style: AppFonts.headingLarge),
                const SizedBox(height: 16),
                Text(description, style: AppFonts.body),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
