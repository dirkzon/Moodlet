import 'package:bletest/comms/hive/models/hiveDesignSettings.dart';
import 'package:bletest/comms/hive/models/hiveNotificationSettings.dart';
import 'package:bletest/settings/settings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class HiveSettingsRepository with ChangeNotifier {
  Box<HiveNotificationSettings> notifications =
      Hive.box<HiveNotificationSettings>("notifications");
  Box<HiveDesignSettings> design = Hive.box<HiveDesignSettings>("design");

  HiveNotificationSettings? getNotificationSettings() {
    return notifications.get('notifications');
  }

  setNotificationSettings(HiveNotificationSettings settings) {
    notifications.put('notifications', settings);
  }

  HiveDesignSettings? getDesignSettings() {
    return design.get('design');
  }

  setDesignSettings(HiveDesignSettings settings) {
    design.put('design', settings);
  }

  updateSettings(SettingsManager manager) {
    setNotificationSettings(HiveNotificationSettings(
        allNotifications: manager.allNotifications,
        journalNotifications: manager.journalNotifications,
        reflectionTime: (manager.reflectionTime.hour * 60) +
            manager.reflectionTime.minute));
    setDesignSettings(HiveDesignSettings(darkMode: manager.darkMode));
  }
}
