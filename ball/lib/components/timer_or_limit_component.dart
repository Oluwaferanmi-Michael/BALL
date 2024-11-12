import 'dart:async';
import 'package:flutter/material.dart';

class TimerOrLimitComponent extends StatefulWidget {
  const TimerOrLimitComponent({
    super.key,
    required this.timerStreamController,
    this.scoreLimit,
    this.duration,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      // check if score limt or duration is null
      child: widget.duration == null
          ? Visibility(
              // display score limit if duration is null
              visible: widget.scoreLimit != null ? true : false,
              child: Text('${widget.scoreLimit}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500)))
          : StreamBuilder<String?>(
              stream: widget.timerStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator when waiting for data.
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Display an error message if an error occurs.
                } else if (!snapshot.hasData) {
                  return const Text(
                      'No data available'); // Display a message when no data is available.
                } else {
                  return Text(
                    '${snapshot.data}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  );
                }
              }),
    );
  }
}
