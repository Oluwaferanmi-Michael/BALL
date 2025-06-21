import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/notifier/game_status_notifier.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScoreSideComponent extends HookConsumerWidget {
  final GameTeams team;
  final TeamName teamName;
  final String score;
  final void Function(int value) increment;

  const ScoreSideComponent({
    super.key,
    required this.score,
    required this.increment,
    required this.teamName,
    required this.team,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStatus = ref.watch(gameStatusNotifierProvider);
    final scoreValue = ['1', '3'];
    return GestureDetector(
      onTap: () {
        if (gameStatus != GameStatus.completed) {
          increment(2);
        }
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width / 2,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(12),
          color: team == GameTeams.away
              ? Colors.blueAccent
              : Colors.amberAccent,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Text(
                    teamName,
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  score,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white70,
                    fontSize: 102,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              Positioned(
                bottom: kBottomNavigationBarHeight * 2.2,
                left: 0,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * .5,
                  child: Column(
                    spacing: 8,
                    children: scoreValue
                        .map(
                          (item) => AddScoreComponent(
                            color: const Color(0xFFFFFDEF),
                            onTap: () {
                              // Take String Value turn it to score value then add to total score.
                              final value = int.parse(item);
                              if (gameStatus != GameStatus.completed) {
                                increment(value);
                              }
                            },
                            team: team,
                            value: item,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddScoreComponent extends StatelessWidget {
  final GameTeams team;
  final String value;
  final Color color;
  final void Function() onTap;
  const AddScoreComponent({
    required this.color,
    required this.onTap,
    super.key,
    required this.team,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: team == GameTeams.away
            ? const EdgeInsets.only(left: 12)
            : const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          // borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),

        child: Center(
          child: Text(
            '+ $value',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
