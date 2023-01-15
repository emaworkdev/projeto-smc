import 'package:flutter/material.dart';

class ChipProvider extends ChangeNotifier {
  static ChipProvider instance = ChipProvider();
  bool isvalue = true;

  changeChip() {
    isvalue = !isvalue;
    notifyListeners();
  }
}
