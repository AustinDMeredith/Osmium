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

  Progresslog({
    required this.name,
    required this.progressMade,
    this.description = 'Add a description',
    DateTime? time,
  }) : time = time ?? DateTime.now();
}