import 'package:bletest/comms/hive/models/hiveBleDevice.dart';
import 'package:bletest/comms/hive/models/hiveDesignSettings.dart';
import 'package:bletest/comms/hive/models/hiveNotificationSettings.dart';
import 'package:bletest/comms/hive/models/hiveProfile.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/hiveEntry.dart';
import 'models/hiveMoment.dart';

class HiveConfig {
  static setUp() async {
    debugPrint('Setting up Hive');
    await Hive.initFlutter();

    //notifications
    Hive.registerAdapter(HiveNotificationSettingsAdapter());
    try {
      await Hive.openBox<HiveNotificationSettings>("notifications");
    } catch (e) {
      if (await Hive.boxExists("notifications")) {
        await Hive.deleteBoxFromDisk("notifications");
      }
      await Hive.openBox<HiveNotificationSettings>("notifications");
    }

    //design
    Hive.registerAdapter(HiveDesignSettingsAdapter());
    try {
      await Hive.openBox<HiveDesignSettings>("design");
    } catch (e) {
      if (await Hive.boxExists("design")) {
        await Hive.deleteBoxFromDisk("design");
      }
      await Hive.openBox<HiveDesignSettings>("design");
    }

    //profile
    Hive.registerAdapter(HiveProfileAdapter());
    try {
      await Hive.openBox<HiveProfile>("profile");
    } catch (e) {
      if (await Hive.boxExists("profile")) {
        await Hive.deleteBoxFromDisk("profile");
      }
      await Hive.openBox<HiveProfile>("profile");
    }

    //entries
    Hive.registerAdapter(HiveEntryAdapter());
    try {
      await Hive.openBox<HiveEntry>("entries");
    } catch (e) {
      if (await Hive.boxExists("entries")) {
        await Hive.deleteBoxFromDisk("entries");
      }
      await Hive.openBox<HiveEntry>("entries");
    }

    //moments
    Hive.registerAdapter(HiveMomentAdapter());
    try {
      await Hive.openBox<HiveMoment>("moments");
    } catch (e) {
      if (await Hive.boxExists("moments")) {
        await Hive.deleteBoxFromDisk("moments");
      }
      await Hive.openBox<HiveMoment>("moments");
    }

    //devices
    Hive.registerAdapter(HiveBleDeviceAdapter());
    try {
      await Hive.openBox<HiveBleDevice>("bleDevices");
    } catch (e) {
      if (await Hive.boxExists("bleDevices")) {
        await Hive.deleteBoxFromDisk("bleDevices");
      }
      await Hive.openBox<HiveBleDevice>("bleDevices");
    }
  }
}
