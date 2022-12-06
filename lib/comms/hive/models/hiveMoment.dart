import 'package:hive/hive.dart';
import '../../../moment/momentEnums.dart';

part 'hiveMoment.g.dart';

@HiveType(typeId: 1)
class HiveMoment extends HiveObject {
  HiveMoment({
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.location,
    required this.pleasure,
    required this.arousal,
    required this.dominance,
    required this.additionalNotes,
  });

  @HiveField(0)
  DateTime startDate;

  @HiveField(1)
  DateTime endDate;

  @HiveField(2)
  String name;

  @HiveField(3)
  String location;

  @HiveField(4)
  Pleasure? pleasure;

  @HiveField(5)
  Arousal? arousal;

  @HiveField(6)
  Dominance? dominance;

  @HiveField(7)
  String additionalNotes;
}
