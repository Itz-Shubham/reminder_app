import 'package:flutter/material.dart';
import 'package:reminder_app/constants.dart';

import '../app_colors.dart';

class TaskNameField extends StatefulWidget {
  const TaskNameField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<TaskNameField> createState() => _TaskNameFieldState();
}

class _TaskNameFieldState extends State<TaskNameField> {
  bool dropDownActive = false;

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height / 3;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(8),
      height: dropDownActive ? totalHeight : 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white70),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: "Task Name",
                    border: InputBorder.none,
                    isCollapsed: true,
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: AppColor.secondaryColor,
                  child: InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() => dropDownActive = !dropDownActive);
                    },
                    child: SizedBox.square(
                      dimension: 42,
                      child: RotatedBox(
                        quarterTurns: dropDownActive ? 3 : 1,
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (dropDownActive)
            Expanded(
              child: Column(
                children: [
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: dailyRoutine.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            "${index + 1}. ${dailyRoutine[index]}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onTap: () {
                            widget.controller.text = dailyRoutine[index];
                            setState(() => dropDownActive = false);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
