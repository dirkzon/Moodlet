// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveNotificationSettings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveNotificationSettingsAdapter
    extends TypeAdapter<HiveNotificationSettings> {
  @override
  final int typeId = 3;

  @override
  HiveNotificationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveNotificationSettings(
      allNotifications: fields[0] == null ? true : fields[0] as bool,
      journalNotifications: fields[1] == null ? true : fields[1] as bool,
      reflectionTime: fields[2] == null ? 1140 : fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveNotificationSettings obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.allNotifications)
      ..writeByte(1)
      ..write(obj.journalNotifications)
      ..writeByte(2)
      ..write(obj.reflectionTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveNotificationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
