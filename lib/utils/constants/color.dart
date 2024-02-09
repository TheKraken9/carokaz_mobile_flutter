
import 'package:flutter/cupertino.dart';

class TColors{
  TColors._();

  //app basic color
  static const Color primary = Color(0xFF3338AF);
  static const Color secondary = Color(0xFFE91E63);
  static const Color accent = Color(0xFF00BCD4);

  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xFF3338AF),
      Color(0xFFE91E63),
      Color(0xFF00BCD4),
    ],
  );

  //Text color
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textWhite = Color(0xFFFFFFFF);

  //Background color
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  //Background container color
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = TColors.light.withOpacity(0.1);

  //Button color
  static const Color buttonPrimary = Color(0xFF3338AF);
  static const Color buttonSecondary = Color(0xFFE91E63);
  static const Color buttonDisabled = Color(0xFFBDBDBD);

  //Border color
  static const Color borderPrimary = Color(0xFFE0E0E0);
  static const Color borderSecondary = Color(0xFFBDBDBD);

  //Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFF9800);
  static const Color success = Color(0xFF4CAF50);
  static const Color info = Color(0xFF2196F3);

  //Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFFDADADA);
  static const Color darkGrey = Color(0xFFD7D7D7);
  static const Color grey = Color(0xFFE2E2E2);
  static const Color softGrey = Color(0xFFBDBDBD);
  static const Color lightGrey = Color(0xFFBDBDBD);
  static const Color white = Color(0xFFFFFFFF);





}