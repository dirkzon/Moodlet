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
      categories: (fields[4] as List).cast<String>(),
      pleasure: fields[5] as int,
      arousal: fields[6] as int,
      dominance: fields[7] as int,
      additionalNotes: fields[8] as String,
      averageMM: fields[9] as int,
      groundMM: fields[10] as int,
      peakMM: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMoment obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.startDate)
      ..writeByte(1)
      ..write(obj.endDate)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.categories)
      ..writeByte(5)
      ..write(obj.pleasure)
      ..writeByte(6)
      ..write(obj.arousal)
      ..writeByte(7)
      ..write(obj.dominance)
      ..writeByte(8)
      ..write(obj.additionalNotes)
      ..writeByte(9)
      ..write(obj.averageMM)
      ..writeByte(10)
      ..write(obj.groundMM)
      ..writeByte(11)
      ..write(obj.peakMM);
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
