import 'dart:async';
import 'package:flutter/material.dart';

class TimerOrLimitComponent extends StatefulWidget {
  const TimerOrLimitComponent({
    super.key,
    required this.timerStreamController,
    required this.scoreLimit,
    required this.duration,
  });

  final StreamController<String> timerStreamController;
  final int? duration;
  final int? scoreLimit;

  @override
  State<TimerOrLimitComponent> createState() => _TimerOrLimitComponentState();
}

class _TimerOrLimitComponentState extends State<TimerOrLimitComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: widget.duration == null
          ? Text('${widget.scoreLimit}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500))
          : StreamBuilder<String?>(
              stream: widget.timerStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Display a loading indicator when waiting for data.
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Display an error message if an error occurs.
                } else if (!snapshot.hasData) {
                  return Text(
                      'No data available'); // Display a message when no data is available.
                } else {
                  return Text(
                    '${snapshot.data}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  );
                }
              }),
    );
  }
}
