import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String type;

  @HiveField(3)
  int startTimeHour;

  @HiveField(4)
  int startTimeMinute;

  @HiveField(5)
  int? endTimeHour;

  @HiveField(6)
  int? endTimeMinute;

  TaskModel(
    this.id,
    this.name,
    this.type,
    this.startTimeHour,
    this.startTimeMinute,
    this.endTimeHour,
    this.endTimeMinute,
  );
}
