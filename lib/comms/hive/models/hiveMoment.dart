import 'package:hive/hive.dart';

part 'hiveMoment.g.dart';

@HiveType(typeId: 1)
class HiveMoment extends HiveObject {
  HiveMoment({
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.location,
    required this.categories,
    required this.pleasure,
    required this.arousal,
    required this.dominance,
    required this.additionalNotes,
    required this.averageMM,
    required this.groundMM,
    required this.peakMM,
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
  List<String> categories;

  @HiveField(5)
  int pleasure;

  @HiveField(6)
  int arousal;

  @HiveField(7)
  int dominance;

  @HiveField(8)
  String additionalNotes;

  @HiveField(9)
  int averageMM;

  @HiveField(10)
  int groundMM;

  @HiveField(11)
  int peakMM;
}
