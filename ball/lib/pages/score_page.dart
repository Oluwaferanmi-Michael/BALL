import 'package:ball/components/dialog/confirm_game_stop_dialog.dart';
import 'package:ball/components/dialog/dialogs.dart';
import 'package:ball/pages/results_page.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:ball/state/models/game_enitity.dart';
import 'package:ball/state/models/scores.dart';
import 'package:ball/state/notifier/game_notifiers/end_game_provider.dart';
import 'package:ball/state/notifier/game_status_notifier.dart';
import 'package:ball/state/notifier/scores_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../components/game_ui_component.dart';
import '../components/score_side_component.dart';
import '../state/models/game_team_names.dart';

class ScorePage extends HookConsumerWidget {
  final GameDuration? duration;
  final ScoreLimit? scoreLimit;
  final TeamNames teamNames;

  const ScorePage({
    super.key,
    this.duration,
    this.scoreLimit,
    required this.teamNames,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final gameStatus = ref.watch(gameStatusNotifierProvider);

    // Hooks
    final homeScore = useState(0);
    final awayScore = useState(0);

    if (gameStatus == GameStatus.completed) {
      final game = Game(
        homeTeamScore: homeScore.value,
        awayTeamScore: awayScore.value,
        scoreLimit: scoreLimit,
        awayTeamName: teamNames.away,
        homeTeamName: teamNames.home,
        winningTeam: homeScore.value > awayScore.value
            ? GameTeams.home
            : GameTeams.away,
      );

      game.debugLog(message: 'game values');

      return ResultsPage(game: game);
    }

    // UI
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        final bool shouldPop =
            await ConfirmGameStopDialog(
              context,
              action: () {
                final game = Game(
                  homeTeamScore: homeScore.value,
                  awayTeamScore: awayScore.value,
                  scoreLimit: scoreLimit,
                  awayTeamName: teamNames.away,
                  homeTeamName: teamNames.home,
                  duration: duration,
                );

                ref.watch(endgameProvider(game: game));
              },
            ).present(context) ??
            false;

        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Home Side
                Flexible(
                  child: ScoreSideComponent(
                    score: '${homeScore.value}',
                    increment: (value) {
                      homeScore.value += value;

                      Scores scores = Scores(
                        awayScore: awayScore.value,
                        homeScore: homeScore.value,
                      );

                      ref
                          .watch(scoresNotifierProvider.notifier)
                          .addScores(scores);

                      '+ $value'.debugLog(
                        message: 'away score: ${awayScore.value}',
                      );

                      if (scoreLimit != null) {
                        if (homeScore.value >= scoreLimit!) {
                          final game = Game(
                            homeTeamScore: homeScore.value,
                            awayTeamScore: awayScore.value,
                            scoreLimit: scoreLimit,
                            awayTeamName: teamNames.away,
                            homeTeamName: teamNames.home,
                            duration: duration,
                          );

                          ref.watch(endgameProvider(game: game));

                          // ref
                          //     .watch(gameStatusNotifierProvider.notifier)
                          //     .setGameStatus(status: GameStatus.completed);
                          // homeScore.value.debugLog(message: 'stop game');
                        }
                      }
                    },
                    teamName: teamNames.home,
                    team: GameTeams.home,
                  ),
                ),

                // Away Side
                Flexible(
                  child: ScoreSideComponent(
                    score: '${awayScore.value}',
                    increment: (value) {
                      awayScore.value += value;

                      Scores scores = Scores(
                        awayScore: awayScore.value,
                        homeScore: homeScore.value,
                      );

                      ref
                          .watch(scoresNotifierProvider.notifier)
                          .addScores(scores);

                      '+ $value'.debugLog(
                        message: 'away score: ${awayScore.value}',
                      );

                      if (scoreLimit != null) {
                        if (awayScore.value >= scoreLimit!) {
                          final game = Game(
                            homeTeamScore: homeScore.value,
                            awayTeamScore: awayScore.value,
                            scoreLimit: scoreLimit,
                            awayTeamName: teamNames.away,
                            homeTeamName: teamNames.home,
                          );
                          ref.watch(endgameProvider(game: game));
                          // ref
                          //     .watch(gameStatusNotifierProvider.notifier)
                          //     .setGameStatus(status: GameStatus.completed);
                        }
                      }
                    },
                    teamName: teamNames.away,
                    team: GameTeams.away,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: kBottomNavigationBarHeight * .2,
              child: GameUIComponent(
                scoreLimit: scoreLimit,
                duration: duration,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
