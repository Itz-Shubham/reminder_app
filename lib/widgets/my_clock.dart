import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyClock extends StatefulWidget {
  const MyClock({super.key, this.textStyle, this.meridiemStyle});
  final TextStyle? textStyle, meridiemStyle;

  @override
  State<MyClock> createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  late Stream<DateTime> timeStream;
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    timeStream = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
      setState(() => currentTime = DateTime.now());
      return currentTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: timeStream,
      builder: (context, snapshot) {
        final timeText = DateFormat('hh:mm').format(
          snapshot.data ?? currentTime,
        );
        final meridiem = DateFormat('a').format(snapshot.data ?? currentTime);

        return Text.rich(
          TextSpan(text: timeText, children: [
            TextSpan(text: ' $meridiem', style: widget.meridiemStyle),
          ]),
          style: widget.textStyle,
        );
      },
    );
  }
}
