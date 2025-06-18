import 'package:flutter/material.dart';

class AppFonts {
  static const String fontFamily = 'Inter'; // Use your own font

  static const TextStyle headingLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.3,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: Colors.white70,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle alarmTime = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle alarmDate = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    color: Colors.white70,
  );

  static const TextStyle smallLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    color: Colors.white,
  );
}
