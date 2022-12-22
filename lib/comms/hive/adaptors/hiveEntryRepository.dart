import 'package:bletest/comms/hive/models/hiveEntry.dart';
import 'package:bletest/recording/recording.dart';
import 'package:bletest/recording/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../../sensor/moodmetric_sensor_manager.dart';

class HiveEntryRepository with ChangeNotifier {
  Box<HiveEntry> box = Hive.box<HiveEntry>("entries");

  List<HiveEntry> getEntries(DateTime from, DateTime to) {
    List<HiveEntry> values = box.values
        .where((HiveEntry entry) =>
            entry.date.millisecondsSinceEpoch > from.millisecondsSinceEpoch &&
            entry.date.millisecondsSinceEpoch < to.millisecondsSinceEpoch)
        .toList();
    return values.isEmpty ? [] : values;
  }

  update(SensorManager manager) {
    if (manager.recording.sessions.isNotEmpty) {
      _saveRecording(manager.recording);
    }
  }

  _saveRecording(Recording rec) {
    debugPrint('saving entries');
    for (Session session in rec.sessions) {
      for (var i = 0; i < session.entries.length; i++) {
        if (session.valid) {
          debugPrint('saving session');
          DateTime date = session.date.add(Duration(minutes: i));
          HiveEntry entry = HiveEntry(date: date, mm: session.entries[i].mm);
          box.put(date.toString(), entry);
        } else {
          debugPrint('invalid session, cannot save');
        }
      }
    }
  }
}
