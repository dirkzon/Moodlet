import 'package:bletest/comms/hive/adaptors/settingsRepository.dart';
import 'package:flutter/material.dart';

class SettingsManager with ChangeNotifier {
  bool darkMode = false;
  bool allNotifications = true;
  bool journalNotifications = true;
  TimeOfDay reflectionTime = const TimeOfDay(hour: 19, minute: 00);

  SettingsManager(HiveSettingsRepository settingsRepo) {
    var notifs = settingsRepo.getNotificationSettings();
    if (notifs != null) {
      allNotifications = notifs.allNotifications;
      journalNotifications = notifs.journalNotifications;
      var hour = notifs.reflectionTime ~/ 60;
      var min = (notifs.reflectionTime - hour * 60);
      reflectionTime = TimeOfDay(hour: hour, minute: min);
    }
    var design = settingsRepo.getDesignSettings();
    if (design != null) {
      darkMode = design.darkMode;
    }
  }

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
