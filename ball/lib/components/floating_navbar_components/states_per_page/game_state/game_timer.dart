// Game Timer for Game UI State
// import 'package:ball/state/notifier/game_time_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameTimer extends ConsumerWidget {
  final int gameDuration;
  final String timeValue;
  const GameTimer(
      {required this.timeValue, required this.gameDuration, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final timerProvider = ref
    //     .watch(gameTimeNotifierProvider(gameDuration: gameDuration).notifier);

    // // timerProvider.stopTimer();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color(0xFFEDEDED),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, spacing: 12, children: [
        const Icon(
            FeatherIcons.pause,
            size: 16,
          ),
        Text(
          timeValue,
          style: const TextStyle(fontSize: 16),
        )
      ]),
    );
  }
}
