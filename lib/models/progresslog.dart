import 'dart:core';
import 'package:hive/hive.dart';
part 'progresslog.g.dart';

@HiveType(typeId: 2)
class Progresslog {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  double progressMade;

  @HiveField(3)
  DateTime time;

  @HiveField(4)
  String isOf;

  @HiveField(5)
  String parentId;

  @HiveField(6)
  int id;

  Progresslog({
    required this.name,
    required this.progressMade,
    required this.id,
    this.isOf = 'null',
    this.parentId = '',
    this.description = 'Add a description',
    DateTime? time,
  }) : time = time ?? DateTime.now();
}