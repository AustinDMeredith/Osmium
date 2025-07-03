// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 1;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      name: fields[0] as String,
      deadline: fields[1] as DateTime?,
      isCompleted: fields[2] as bool,
      status: fields[3] as String,
      progressWeight: fields[4] as double,
      isStarted: fields[5] as bool,
      isOf: fields[6] as String,
      parentId: fields[7] as String,
      id: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.deadline)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.progressWeight)
      ..writeByte(5)
      ..write(obj.isStarted)
      ..writeByte(6)
      ..write(obj.isOf)
      ..writeByte(7)
      ..write(obj.parentId)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
