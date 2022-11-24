import 'package:bletest/recording/entry.dart';
import 'package:bletest/recording/recording.dart';
import 'package:flutter/cupertino.dart';

import '../hive/models/hiveEntry.dart';

abstract class EntryPort with ChangeNotifier {
  List<HiveEntry> getEntries(DateTime start, DateTime end);
  void saveEntries(Recording recording);
}
