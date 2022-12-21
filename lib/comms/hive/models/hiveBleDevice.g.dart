// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveBleDevice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveBleDeviceAdapter extends TypeAdapter<HiveBleDevice> {
  @override
  final int typeId = 6;

  @override
  HiveBleDevice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveBleDevice(
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveBleDevice obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveBleDeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
