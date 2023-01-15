import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum AppTheme{Light, Dark}

double screenWidth(BuildContext context)=>MediaQuery.of(context).size.width;
double screenHeight(BuildContext context)=>MediaQuery.of(context).size.height;

final appThemeData = {
  AppTheme.Light :  ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue[900],
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.grey[100], colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.blueAccent)
  ),
  AppTheme.Dark :  ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF294c60),
    scaffoldBackgroundColor: Colors.grey[800],
    bottomAppBarColor: Colors.grey[700], colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(secondary: Colors.lightBlueAccent)
  )
};

bool isDark(BuildContext context)=>Theme.of(context).brightness == Brightness.dark;
