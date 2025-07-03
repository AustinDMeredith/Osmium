// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final int typeId = 0;

  @override
  Goal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goal(
      name: fields[0] as String,
      id: fields[8] as String,
      description: fields[1] as String,
      targetValue: fields[2] as double,
      currentProgress: fields[3] as double,
      isCompleted: fields[5] as bool,
      progressLogs: (fields[6] as List?)?.cast<Progresslog>(),
      tasks: (fields[7] as List?)?.cast<Task>(),
    )..deadline = fields[4] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.targetValue)
      ..writeByte(3)
      ..write(obj.currentProgress)
      ..writeByte(4)
      ..write(obj.deadline)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.progressLogs)
      ..writeByte(7)
      ..write(obj.tasks)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
