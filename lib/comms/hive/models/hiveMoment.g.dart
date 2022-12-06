// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveMoment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMomentAdapter extends TypeAdapter<HiveMoment> {
  @override
  final int typeId = 1;

  @override
  HiveMoment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMoment(
      startDate: fields[0] as DateTime,
      endDate: fields[1] as DateTime,
      name: fields[2] as String,
      location: fields[3] as String,
      pleasure: fields[4] as Pleasure?,
      arousal: fields[5] as Arousal?,
      dominance: fields[6] as Dominance?,
      additionalNotes: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMoment obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.startDate)
      ..writeByte(1)
      ..write(obj.endDate)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.pleasure)
      ..writeByte(5)
      ..write(obj.arousal)
      ..writeByte(6)
      ..write(obj.dominance)
      ..writeByte(7)
      ..write(obj.additionalNotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMomentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
