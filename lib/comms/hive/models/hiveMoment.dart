import 'package:hive/hive.dart';

part 'hiveMoment.g.dart';

@HiveType(typeId: 1)
class HiveMoment extends HiveObject {
  HiveMoment(
      {required this.startDate,
      required this.endDate,
      required this.name,
      required this.location});

  @HiveField(0)
  DateTime startDate;

  @HiveField(1)
  DateTime endDate;

  @HiveField(2)
  String name;

  @HiveField(3)
  String location;
}
