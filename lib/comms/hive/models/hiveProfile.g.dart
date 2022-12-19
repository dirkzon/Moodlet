// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveProfile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveProfileAdapter extends TypeAdapter<HiveProfile> {
  @override
  final int typeId = 5;

  @override
  HiveProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveProfile(
      birthDay: fields[0] as DateTime,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveProfile obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.birthDay)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
