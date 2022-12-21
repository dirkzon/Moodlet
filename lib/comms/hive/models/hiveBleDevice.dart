import 'package:hive/hive.dart';

part 'hiveBleDevice.g.dart';

@HiveType(typeId: 6)
class HiveBleDevice extends HiveObject {
  HiveBleDevice({required this.id});

  @HiveField(0)
  String id;
}
