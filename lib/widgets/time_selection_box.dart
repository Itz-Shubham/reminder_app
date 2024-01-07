import 'package:flutter/material.dart';

class TimeSelectionBox extends StatelessWidget {
  const TimeSelectionBox({
    super.key,
    required this.width,
    required this.hintText,
    this.initialTimeOfDay,
    required this.onTimeSelect,
  });

  final double width;
  final String hintText;
  final TimeOfDay? initialTimeOfDay;
  final Function(TimeOfDay) onTimeSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: Colors.white60),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          final time = await showTimePicker(
            context: context,
            initialTime: initialTimeOfDay ?? TimeOfDay.now(),
          );
          if (time != null) onTimeSelect(time);
        },
        child: Center(child: Text(hintText)),
      ),
    );
  }
}
