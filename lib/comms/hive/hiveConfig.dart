import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/hiveEntry.dart';
import 'models/hiveMoment.dart';

class HiveConfig {
  static setUp() async {
    debugPrint('Setting up Hive');
    await Hive.initFlutter();

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
  }
}
