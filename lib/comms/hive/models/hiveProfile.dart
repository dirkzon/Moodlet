import 'package:hive/hive.dart';

part 'hiveProfile.g.dart';

@HiveType(typeId: 5)
class HiveProfile extends HiveObject {
  HiveProfile({required this.birthDay, required this.name});

  @HiveField(0)
  DateTime birthDay;

  @HiveField(1, defaultValue: '')
  String name;
}
