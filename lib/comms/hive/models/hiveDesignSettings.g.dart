// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveDesignSettings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDesignSettingsAdapter extends TypeAdapter<HiveDesignSettings> {
  @override
  final int typeId = 4;

  @override
  HiveDesignSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDesignSettings(
      darkMode: fields[0] == null ? false : fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDesignSettings obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.darkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDesignSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
