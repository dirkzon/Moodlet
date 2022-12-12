import 'package:flutter/material.dart';

class SettingsManager with ChangeNotifier {
  bool darkMode = false;
  bool allNotifications = true;
  bool journalNotifications = true;
  TimeOfDay reflectionTime = const TimeOfDay(hour: 19, minute: 00);

  setDarkMode(bool value) {
    darkMode = value;
    notifyListeners();
  }

  setAllNotifications(bool value) {
    allNotifications = value;
    setJournalNotifications(value);
  }

  setReflectionTime(TimeOfDay time) {
    reflectionTime = time;
    notifyListeners();
  }

  setJournalNotifications(bool value) {
    journalNotifications = value;
    notifyListeners();
  }
}
