// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveEntry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEntryAdapter extends TypeAdapter<HiveEntry> {
  @override
  final int typeId = 0;

  @override
  HiveEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEntry(
      date: fields[0] as DateTime,
      mm: fields[1] == null ? 0 : fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.mm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
