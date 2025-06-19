import 'package:ball/pages/results_page.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/models/game_enitity.dart';
import 'package:ball/state/notifier/game_notifiers/end_game_provider.dart';
import 'package:ball/state/notifier/game_notifiers/game_score_limit_notifier.dart';
import 'package:ball/state/notifier/game_status_notifier.dart';
import 'package:ball/state/notifier/game_team_names_notifier.dart';
import 'package:ball/state/notifier/game_time_notifier.dart';
import 'package:ball/state/notifier/scores_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'floating_navbar_components/states_per_page/game_state/game_timer.dart';

class TimerOrLimitComponent extends ConsumerWidget {
  const TimerOrLimitComponent({
    super.key,
    required this.duration,
    this.scoreLimit,
  });

  // final StreamController<String> timerStreamController;
  final int? duration;
  final int? scoreLimit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerProvider = ref.watch(
      gameTimeNotifierProvider(gameDuration: duration).notifier,
    );

    return duration == null
        ? Visibility(
            // display score limit if duration is null
            visible: true,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFEDEDED),
              ),
              child: Text(
                '$scoreLimit',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        : ref
              .watch(gameTimeNotifierProvider(gameDuration: duration!))
              .when(
                data: (data) {
                  final gameStatus = ref.watch(gameStatusNotifierProvider);

                  final scores = ref.watch(scoresNotifierProvider);
                  final teamNames = ref.read(gameTeamNameNotifierProvider);
                  final scoreLimit = ref.read(gameScoreLimitNotifierProvider);

                  final game = Game(
                    homeTeamScore: scores.homeScore,
                    awayTeamScore: scores.awayScore,
                    scoreLimit: scoreLimit,
                    awayTeamName: teamNames.away,
                    homeTeamName: teamNames.home,
                  );

                  if (gameStatus == GameStatus.completed) {
                    ref.watch(endgameProvider(game: game));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsPage(game: game),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () => timerProvider.pauseOrResumeTimer(),
                    child: GameTimer(timeValue: data, gameDuration: duration!),
                  );
                },
                error: (err, stck) => Text(err.toString()),
                loading: () => Container(
                  padding: const EdgeInsets.all(8),
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFFEDEDED),
                  ),
                  child: const LinearProgressIndicator(),
                ),
              );
  }
}
