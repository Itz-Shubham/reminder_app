import 'package:flutter/material.dart';
import 'package:reminder_app/models/task_model.dart';

String getNextUpcomingTask(BuildContext context, List<TaskModel> tasks) {
  final now = TimeOfDay.now();
  int index = tasks.indexWhere((element) => element.startTimeHour > now.hour);
  if (index == -1) {
    return "";
  } else {
    return "${tasks[index].name} at ${TimeOfDay(hour: tasks[index].startTimeHour, minute: tasks[index].startTimeMinute).format(context)}";
  }
}
