import 'package:bletest/comms/hive/models/hiveMoment.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class HiveMomentRepository with ChangeNotifier {
  Box<HiveMoment> box = Hive.box<HiveMoment>("moments");

  List<HiveMoment> getMoments(DateTime from, DateTime to) {
    List<HiveMoment> values = box.values
        .where((HiveMoment moment) =>
            moment.startDate?.millisecondsSinceEpoch >
                from.millisecondsSinceEpoch &&
            moment.startDate?.millisecondsSinceEpoch <
                to.millisecondsSinceEpoch)
        .toList();
    return values.isEmpty ? [] : values;
  }

  getMoment(Uuid id) {
    HiveMoment? moment = box.get(id);
    return moment;
  }

  saveMoment(HiveMoment moment) {
    box.put(const Uuid(), moment);
  }
}
