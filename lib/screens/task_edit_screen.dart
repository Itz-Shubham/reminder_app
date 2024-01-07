import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_app/models/task_model.dart';
import 'package:reminder_app/services/notification_service.dart';
import 'package:reminder_app/utils/create_task_duration_string.dart';
import 'package:reminder_app/utils/guess_task_type_by_title.dart';
import 'package:reminder_app/utils/show_alert.dart';
import 'package:reminder_app/widgets/my_textfield.dart';
import 'package:reminder_app/widgets/time_selection_box.dart';

class TaskEditScreen extends StatefulWidget {
  const TaskEditScreen({super.key, this.task});
  final TaskModel? task;

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final _taskNameEditingController = TextEditingController();
  TimeOfDay? _startTime, _endTime;

  @override
  void initState() {
    if (widget.task != null) {
      _taskNameEditingController.text = widget.task!.name;
      _startTime = TimeOfDay(
        hour: widget.task!.startTimeHour,
        minute: widget.task!.startTimeMinute,
      );
      if (widget.task?.endTimeHour != null &&
          widget.task?.endTimeMinute != null) {
        _endTime = TimeOfDay(
          hour: widget.task!.endTimeHour!,
          minute: widget.task!.endTimeMinute!,
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = MaterialLocalizations.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.keyboard_backspace_rounded),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            if (widget.task != null)
              IconButton(
                onPressed: () {
                  Hive.box<TaskModel>('tasks').delete(widget.task!.id);
                  Navigator.pop(context);
                  showSuccessAlert(context, "Deleted Successfully!");
                  NotificationService.removeNotification(widget.task!.id);
                },
                icon: const Icon(Icons.delete_forever_rounded),
                color: Colors.red,
              )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              SizedBox(
                height: deviceSize.height * 0.3,
                child: Center(
                  child: Text(
                    widget.task != null ? "Edit Task" : "Add Task",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TaskNameField(controller: _taskNameEditingController),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(),
                  const Text(
                    "Time: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TimeSelectionBox(
                    width: deviceSize.width / 4,
                    hintText: _startTime == null
                        ? "Start at"
                        : localization.formatTimeOfDay(_startTime!),
                    initialTimeOfDay: _startTime,
                    onTimeSelect: (time) => setState(() => _startTime = time),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("-", style: TextStyle(fontSize: 20)),
                  ),
                  TimeSelectionBox(
                    width: deviceSize.width / 4,
                    hintText: _endTime == null
                        ? "End at"
                        : localization.formatTimeOfDay(_endTime!),
                    initialTimeOfDay: _endTime,
                    onTimeSelect: (time) => setState(() => _endTime = time),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 32),
              const Spacer(),
              ElevatedButton(
                onPressed: onDoneButtonClick,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(deviceSize.width * 0.6, 48),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Done"),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void onDoneButtonClick() {
    final title = _taskNameEditingController.text;
    if (title.length < 2) {
      showErrorAlert(context, "Enter a valid task name");
      return;
    }
    if (_startTime == null) {
      showErrorAlert(context, "Choose time for your task");
      return;
    }
    late int id;
    final taskBox = Hive.box<TaskModel>('tasks');
    if (widget.task != null) {
      id = widget.task!.id;
    } else {
      id = taskBox.length <= 0 ? 0 : taskBox.values.last.id + 1;
    }

    NotificationService.removeNotification(id);
    Hive.box<TaskModel>('tasks').put(
      id,
      TaskModel(id, title, guessTaskTypeByTitle(title), _startTime!.hour,
          _startTime!.minute, _endTime?.hour, _endTime?.minute),
    );
    NotificationService.createNotification(id, title,
        createTaskDurationString(context, _startTime!, _endTime), _startTime!);

    Navigator.pop(context);
  }
}
