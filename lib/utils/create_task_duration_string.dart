import 'package:flutter/material.dart';

String createTaskDurationString(
    BuildContext context, TimeOfDay startTime, TimeOfDay? endTime) {
  String string = startTime.format(context);
  if (endTime != null) {
    string += ' - ${endTime.format(context)}';
  }
  return string;
}
