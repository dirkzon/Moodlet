import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'hiveNotificationSettings.g.dart';

@HiveType(typeId: 3)
class HiveNotificationSettings extends HiveObject {
  HiveNotificationSettings(
      {required this.allNotifications,
      required this.journalNotifications,
      required this.reflectionTime});

  @HiveField(0, defaultValue: true)
  bool allNotifications;

  @HiveField(1, defaultValue: true)
  bool journalNotifications;

  @HiveField(2, defaultValue: 19 * 60)
  int reflectionTime;
}
