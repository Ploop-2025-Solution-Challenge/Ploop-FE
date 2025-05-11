import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextTheme ploopTextTheme() {
  return TextTheme(
// App Title
    displayLarge: TextStyle(
      fontSize: 34.sp,
      fontFamily: 'SF-Pro-Display',
      fontWeight: FontWeight.w700,
      height: 1.21,
      letterSpacing: Platform.isIOS ? 0.40 : 0.26,
    ),
    // Picked litter display
    /* copy this theme for total challenge status */
    displayMedium: TextStyle(
      fontSize: 60.sp,
      fontFamily: 'FugazOne',
      // default fontweight
      height: 0.82,
      letterSpacing: Platform.isIOS ? 0.40 : 0.26,
    ),
    // Data value display
    displaySmall: TextStyle(
        fontSize: 22.sp,
        fontFamily: 'SF-Pro-Display',
        fontWeight: FontWeight.w700,
        height: 1.27,
        letterSpacing: Platform.isIOS ? -0.45 : -0.29),
    // Page title
    headlineLarge: TextStyle(
      fontSize: 21.sp,
      fontFamily: 'SF-Pro-Display',
      fontWeight: FontWeight.w600,
      height: 1.25,
      letterSpacing: Platform.isIOS ? -0.15 : -0.1,
    ),
    // Page title 2
    headlineMedium: TextStyle(
      fontSize: 20.sp,
      fontFamily: 'SF-Pro',
      fontWeight: FontWeight.w400,
      height: 1.25,
      letterSpacing: Platform.isIOS ? -0.45 : -0.29,
    ),

    // Section Title
    titleLarge: TextStyle(
      fontSize: 16.sp,
      fontFamily: 'SF-Pro-Display',
      fontWeight: FontWeight.w600,
      height: 1.33,
      letterSpacing: Platform.isIOS ? 0.12 : 0.08,
    ),
    // Section title 2
    titleMedium: TextStyle(
      fontSize: 15.sp,
      fontFamily: 'SF-Pro',
      fontWeight: FontWeight.w400,
      height: 1.33,
      letterSpacing: Platform.isIOS ? -0.23 : -0.15,
    ),
    // Button1, Data unit display
    labelLarge: TextStyle(
      fontSize: 18.sp,
      fontFamily: 'SF-Pro-Display',
      fontWeight: FontWeight.w600,
      height: 1.29,
      letterSpacing: Platform.isIOS ? -0.08 : -0.05,
    ),
    // Button2
    labelMedium: TextStyle(
      fontSize: 15.sp,
      fontFamily: 'SF-Pro-Display',
      fontWeight: FontWeight.w600,
      height: 1.33,
      letterSpacing: Platform.isIOS ? 0.06 : -0.04,
    ),
    // Navigation bar
    labelSmall: TextStyle(
      fontSize: 11.sp,
      fontFamily: 'SF-Pro',
      fontWeight: FontWeight.w400,
      height: 1.18,
      letterSpacing: Platform.isIOS ? 0.06 : 0.6,
    ),
    // Content
    /* copy this theme for filter buttons on map */
    bodyLarge: TextStyle(
      fontSize: 17.sp,
      fontFamily: 'SF-Pro',
      fontWeight: FontWeight.w400,
      height: 1.29,
      letterSpacing: Platform.isIOS ? -0.43 : -0.28,
    ),

    // Personal challenge status
    bodyMedium: TextStyle(
      fontSize: 18.sp,
      fontFamily: 'SF-Pro-Display',
      fontWeight: FontWeight.w600,
      height: 1.31,
      letterSpacing: Platform.isIOS ? -0.31 : -0.20,
    ),
    // Challenge profile name
    /* copy this theme for activity details */
    bodySmall: TextStyle(
      fontSize: 13.sp,
      fontFamily: 'SF-Pro',
      fontWeight: FontWeight.w400,
      height: 1.38,
      letterSpacing: Platform.isIOS ? -0.08 : 0.3,
    ),
  );
}

class GrayScale {
  static const Color black = Color(0xFF000000);
  static const Color gray_500 = Color(0xFF7E7D7D);
  static const Color gray_400 = Color(0xFFA6A6A6);
  static const Color gray_300 = Color(0xFFA1A1A1);
  static const Color gray_200 = Color(0xFFC0C0C0);
  static const Color gray_100 = Color(0xFFD2D2D2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color shadowColor = Color.fromARGB(62, 0, 0, 0);
  static const Color transparentBlack = Color(0xCC2F2F2F);
}

abstract class ColorTheme {
  Color get color_600;
  Color get color_500;
  Color get color_400;
  Color get state;
  Color get route;
  Color get recommend;
}

class GreenTheme implements ColorTheme {
  @override
  final Color color_600 = const Color(0xFF7EF18D);

  @override
  final Color color_500 = const Color(0xFF23BC37);

  @override
  final Color color_400 = const Color(0xFFC0FFC8);

  @override
  final Color state = const Color(0xFFFF5F5F);
  @override
  final Color recommend = const Color(0xFF6B9FFF);

  @override
  final Color route = const Color(0xFF10AB37);
}

// test color theme
class BlueTheme implements ColorTheme {
  @override
  final Color color_600 = const Color(0xFF7EBFF1);

  @override
  final Color color_500 = const Color(0xFF2375BC);

  @override
  final Color color_400 = const Color(0xFFC0E2FF);

  @override
  final Color state = const Color(0xFFFF5F5F);

  @override
  final Color route = const Color(0xFF6B9FFF);

  @override
  final Color recommend = const Color(0xFF6B9FFF);
}

// test color theme
class YellowTheme implements ColorTheme {
  @override
  final Color color_600 = const Color(0xFFF1E97E);

  @override
  final Color color_500 = const Color(0xFFBCBC23);

  @override
  final Color color_400 = const Color(0xFFFCFFC0);

  @override
  final Color state = const Color(0xFFFF5F5F);

  @override
  final Color route = const Color(0xFF6B9FFF);

  @override
  final Color recommend = const Color(0xFF6B9FFF);
}

ColorTheme theme() {
  return GreenTheme();
}
