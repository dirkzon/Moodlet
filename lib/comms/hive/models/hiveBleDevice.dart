import 'package:hive/hive.dart';

part 'hiveBleDevice.g.dart';

@HiveType(typeId: 6)
class HiveBleDevice extends HiveObject {
  HiveBleDevice(
      {required this.id, required this.name, required this.autoConnect});

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool autoConnect;
}
