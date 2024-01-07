import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_app/app_colors.dart';
import 'package:reminder_app/models/task_model.dart';
import 'package:reminder_app/utils/get_next_upcoming_task.dart';
import 'package:reminder_app/widgets/my_clock.dart';
import 'package:reminder_app/widgets/reminder_card.dart';

import 'task_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];

  @override
  void initState() {
    tasks = Hive.box<TaskModel>('tasks').values.toList();
    tasks.sort((a, b) => a.startTimeMinute.compareTo(b.startTimeMinute));
    tasks.sort((a, b) => a.startTimeHour.compareTo(b.startTimeHour));
    if (mounted) setState(() {});
    Hive.box<TaskModel>('tasks').listenable().addListener(() {
      tasks = Hive.box<TaskModel>('tasks').values.toList();
      tasks.sort((a, b) => a.startTimeMinute.compareTo(b.startTimeMinute));
      tasks.sort((a, b) => a.startTimeHour.compareTo(b.startTimeHour));
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: deviceSize.height * 0.25,
            backgroundColor: AppColor.cardBackgroundColor,
            flexibleSpace: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyClock(
                    textStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    meridiemStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    getNextUpcomingTask(context, tasks),
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
          ),
          tasks.isEmpty
              ? const SliverFillRemaining(
                  child: Center(child: Text("No Task Added yet!")),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  sliver: SliverList.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) =>
                        ReminderCard(task: tasks[index]),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TaskEditScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
