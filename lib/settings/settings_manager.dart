import 'package:flutter/material.dart';

class SettingsManager with ChangeNotifier {
  bool darkMode = false;

  setDarkMode(bool value) {
    darkMode = value;
    notifyListeners();
  }
}
