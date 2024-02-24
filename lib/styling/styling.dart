import 'dart:ui';

import 'package:flutter/material.dart';

abstract class CustomColors {
  static const main = Color(0xFFF9F9F9);

  static const layer = Color(0xFFF2F2F2);

  static const accentPrimary = Color(0xFF1463F5);
  static const accentSecondary = Color(0xFFE5EDFF);

  static const textPrimaryColor = Color(0xFF211814);
  static const placeholder = Color(0xFFBFBFBF);

  static const colorSheme = ColorScheme.light(background: main);
}

abstract class CustomTextSyles {
  static const main = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.9,
      letterSpacing: 0,
      color: CustomColors.textPrimaryColor);

  static const mainWithPrimaryColor = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.9,
      letterSpacing: 0,
      color: CustomColors.accentPrimary);

  static const body = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: CustomColors.textPrimaryColor);

  static const placeholder = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 2,
      letterSpacing: 0,
      color: CustomColors.placeholder);
}
