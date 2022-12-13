import 'package:hive/hive.dart';

part 'hiveDesignSettings.g.dart';

@HiveType(typeId: 4)
class HiveDesignSettings extends HiveObject {
  HiveDesignSettings({required this.darkMode});

  @HiveField(0, defaultValue: false)
  bool darkMode;
}
