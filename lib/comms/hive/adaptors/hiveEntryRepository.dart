import 'package:bletest/comms/hive/models/hiveEntry.dart';
import 'package:bletest/recording/recording.dart';
import 'package:bletest/recording/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class HiveEntryRepository with ChangeNotifier {
  Box<HiveEntry> box = Hive.box<HiveEntry>("entries");

  List<HiveEntry> getEntries(DateTime start, DateTime end) {
    return box.values
        .where((HiveEntry entry) =>
            entry.date.millisecondsSinceEpoch > start.millisecondsSinceEpoch &&
            entry.date.millisecondsSinceEpoch < end.millisecondsSinceEpoch)
        .toList();
  }

  saveEntries(Recording rec) {
    for (Session session in rec.sessions) {
      for (var i = 0; i < session.entries.length; i++) {
        DateTime date = session.date.add(Duration(minutes: i));
        HiveEntry entry = HiveEntry(date: date, mm: session.entries[i].mm);
        box.put(date, entry);
      }
    }
  }
}
