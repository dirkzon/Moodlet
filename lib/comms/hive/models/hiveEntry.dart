import 'package:hive/hive.dart';

part 'hiveEntry.g.dart';

@HiveType(typeId: 0)
class HiveEntry extends HiveObject {
  HiveEntry({required this.date, required this.mm});

  @HiveField(0)
  DateTime date;

  @HiveField(1, defaultValue: 0)
  int mm;
}
