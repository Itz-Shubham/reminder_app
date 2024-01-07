import 'package:flutter/material.dart';
import 'package:reminder_app/app_colors.dart';
import 'package:reminder_app/models/task_model.dart';
import 'package:reminder_app/screens/task_edit_screen.dart';
import 'package:reminder_app/utils/create_task_duration_string.dart';
import 'package:reminder_app/utils/guess_task_asset_icon_by_task_type.dart';
import 'package:reminder_app/utils/guess_task_type_by_title.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColor.cardBackgroundColor,
      surfaceTintColor: AppColor.cardBackgroundColor,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TaskEditScreen(task: task),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox.square(
                  dimension: 48,
                  child: ColoredBox(
                    color: AppColor.cardBackgroundColor2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        guessTaskAssetIconByTaskType(
                          guessTaskTypeByTitle(task.type),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: createTaskDurationString(
                            context,
                            TimeOfDay(
                                hour: task.startTimeHour,
                                minute: task.startTimeMinute),
                            task.endTimeHour != null &&
                                    task.endTimeMinute != null
                                ? TimeOfDay(
                                    hour: task.endTimeHour!,
                                    minute: task.endTimeMinute!)
                                : null),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
