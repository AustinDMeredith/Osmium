// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progresslog.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgresslogAdapter extends TypeAdapter<Progresslog> {
  @override
  final int typeId = 2;

  @override
  Progresslog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Progresslog(
      name: fields[0] as String,
      progressMade: fields[2] as double,
      id: fields[6] as int,
      isOf: fields[4] as String,
      parentId: fields[5] as String,
      description: fields[1] as String,
      time: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Progresslog obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.progressMade)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.isOf)
      ..writeByte(5)
      ..write(obj.parentId)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgresslogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
