import 'package:flutter/material.dart';

class AuthThemeData {
  final Color? primaryColor;
  final Color? backgroundColor;
  final TextStyle? titleTextStyle;
  final TextStyle? buttonTextStyle;
  final InputDecorationTheme? inputDecorationTheme;
  final ButtonStyle? primaryButtonStyle;
  final ButtonStyle? secondaryButtonStyle;

  const AuthThemeData({
    this.primaryColor,
    this.backgroundColor,
    this.titleTextStyle,
    this.buttonTextStyle,
    this.inputDecorationTheme,
    this.primaryButtonStyle,
    this.secondaryButtonStyle,
  });

  static AuthThemeData get defaultTheme => AuthThemeData(
    primaryColor: Colors.blue,
    backgroundColor: Colors.white,
    titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    buttonTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.grey[100],
    ),
  );
}
