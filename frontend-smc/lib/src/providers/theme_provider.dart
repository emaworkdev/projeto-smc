import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static ThemeProvider instance = ThemeProvider();
  bool isDarkTheme = false;
  bool isMenu = false;
  int whatsDesconect = 0;
  String rota = 'conections';

  changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  changeMenu() {
    isMenu = !isMenu;
    notifyListeners();
  }

  setaRota(String value) {
    rota = value;
    notifyListeners();
  }

  setaWhatsDesconect(int value) {
    whatsDesconect = value;
    notifyListeners();
  }
}
