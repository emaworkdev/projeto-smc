// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const colorAppBar = Color(0xFF2A2D3E); //Color.fromARGB(255, 21, 61, 110);
const colorBackground = Color.fromARGB(255, 212, 209, 211);
const colorBackgroundDark = Color(0xFF4C4C4E);

const corBotaoLogin = Color.fromRGBO(18, 24, 36, 1.0);

const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF3F4046);
const primaryColor = Colors.blue;
const defaultPadding = 16.0;

TextStyle menuListTileDefaultText = const TextStyle(
    color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold);
TextStyle menuListTileSelectedText = const TextStyle(
    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
TextStyle cardTileSubText = const TextStyle(
    color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal);
TextStyle cardTileTitleText = const TextStyle(
    color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal);
TextStyle cardTileMainText = const TextStyle(
    color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold);
TextStyle cardTitleTextStyle =
    const TextStyle(fontSize: 18, color: Colors.black87);

Color selectedColor = const Color(0xFF4AC8EA);
Color drawerBgColor = const Color(0xFF272D34);
Color topBgColor = const Color(0xFF2EB8CA); //0xFF42CEE1

//Thema Card Grid Menu Mobile
const gradientCardGridMobile1 = Color(0xFF515457);
const gradientCardGridMobile2 = Color(0xFF353D44);

const gradientButtonMenu = LinearGradient(colors: [
  Color(0xFF515457),
  Color(0xFF353D44),
]);

class AppColors {
  static const blue = Color.fromARGB(255, 21, 61, 110);

  static const Color cinza_background = Color.fromARGB(255, 242, 244, 245);
  static const Color cinza_datatable = Color.fromARGB(255, 212, 209, 211);
  static const Color cinza_606060 = Color.fromARGB(255, 60, 60, 60);
  static const Color darkBlue =
      Color(0xFF272729); //Color.fromARGB(255, 18, 32, 47);
  static const Color darkPink = Color(0xFF1F1920);
  static const Color dartGreen = Color(0xFF294c60);
}

enum AppTheme { Light, Dark }

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

final appThemeData = {
  AppTheme.Light: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black87,
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Colors.grey[100],
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: Colors.blueAccent)),
  AppTheme.Dark: ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF294c60),
      scaffoldBackgroundColor: Colors.grey[800],
      bottomAppBarColor: Colors.grey[700],
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
          .copyWith(secondary: Colors.lightBlueAccent))
};

bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;
