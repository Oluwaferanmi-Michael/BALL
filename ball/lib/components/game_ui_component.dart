import 'package:ball/components/timer_or_limit_component.dart';
import 'package:ball/pages/results_page.dart';
import 'package:ball/state/notifier/game_notifiers/end_game_provider.dart';
import 'package:ball/state/notifier/game_notifiers/game_score_limit_notifier.dart';
import 'package:ball/state/notifier/game_sound_notifier.dart';

import 'package:ball/state/notifier/game_team_names_notifier.dart';
import 'package:ball/state/notifier/scores_notifier.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/models/game_enitity.dart';
import 'floating_navbar_components/game_controls_tile.dart';
import 'floating_navbar_components/nav_bar_tile.dart';

class GameUIComponent extends ConsumerWidget {
  final GameDuration? duration;
  final ScoreLimit? scoreLimit;
  final void Function()? endGame;
  const GameUIComponent({this.duration, this.scoreLimit, this.endGame, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    

    final items = [
      GameControlsItem(
        icon: FeatherIcons.stopCircle,
        label: 'end game',
        color: Colors.orange,
        function: () {
          final scores = ref.watch(scoresNotifierProvider);
          final teamNames = ref.read(gameTeamNameNotifierProvider);
          final scoreLimit = ref.read(gameScoreLimitNotifierProvider);
          // final duration = ref.read(gameDurationNotifierProvider);

          final game = Game(
            homeTeamScore: scores.homeScore,
            awayTeamScore: scores.awayScore,
            scoreLimit: scoreLimit,
            awayTeamName: teamNames.away,
            homeTeamName: teamNames.home,
          );
          ref.watch(endgameProvider(game: game));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultsPage(game: game)),
          );
        },
      ),
      GameControlsItem(
        icon: FeatherIcons.bell,
        label: 'buzzer',
        function: () => ref.read(gameSoundNotifierProvider.notifier).buzzer(),
      ),
      GameControlsItem(
        icon: FeatherIcons.volume2,
        label: 'whistle',
        function: () => ref.read(gameSoundNotifierProvider.notifier).whistle(),
      ),
    ];

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.sizeOf(context).width,
      height: kBottomNavigationBarHeight * 2,
      // color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          // Time Or Limit Widget
          TimerOrLimitComponent(scoreLimit: scoreLimit, duration: duration),

          // Game Control Widgets
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xFFEDEDED),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  // Main Nav Items
                  children: items.map((gameControl) {
                    return GameScreenTile(
                      color: gameControl.color,
                      onSelected: gameControl.function,
                      icon: gameControl.icon,
                      label: gameControl.label,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
