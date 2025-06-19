import 'package:ball/components/floating_navbar_components/nav_bar_tile.dart';

import 'package:ball/state/models/game_enitity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResultsPage extends HookConsumerWidget {
  final Game game;

  const ResultsPage({required this.game, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Home Side
              Flexible(
                child: ResultsSideComponent(
                  winner: game.winningTeam == GameTeams.home ? true : false,
                  team: GameTeams.home,
                  teamName: game.homeTeamName,
                  score: game.homeTeamScore,
                ),
              ),
              Flexible(
                child: ResultsSideComponent(
                  winner: game.winningTeam == GameTeams.away ? true : false,
                  team: GameTeams.away,
                  teamName: game.awayTeamName,
                  score: game.awayTeamScore,
                ),
              ),
            ],
          ),

          Positioned(
            bottom: kBottomNavigationBarHeight * .2,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFFEDEDED),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(50, 21, 21, 21),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: GameScreenTile(
                onSelected: () => Navigator.pop(context),
                icon: FeatherIcons.chevronLeft,
                label: 'back to game list',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultsSideComponent extends ConsumerWidget {
  const ResultsSideComponent({
    required this.team,
    required this.teamName,
    required this.score,
    required this.winner,
    super.key,
  });

  final GameTeams team;
  final TeamName teamName;
  final int score;
  final bool? winner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Opacity(
      opacity: winner! == true ? 1 : .5,
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
            alignment: Alignment.center,
            children: [
              const SizedBox(height: 24),

              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Text(
                    teamName,
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '$score',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white70,
                    fontSize: 102,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Positioned(
                top: kBottomNavigationBarHeight,
                child: Visibility(
                  visible: winner!,
                  child: Center(
                    child: Text(
                      'WINNER',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white70,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
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
