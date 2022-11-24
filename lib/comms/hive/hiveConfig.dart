import 'package:hive_flutter/hive_flutter.dart';

import 'models/hiveEntry.dart';

class HiveConfig {
  static setUp() async {
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
  }
}
