import 'package:ball/pages/game_list.dart';
import 'package:ball/state/models/game_enititty.dart';
// import 'package:ball/state/notifier/game_notifier.dart';
// import 'package:ball/state/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/winner_card.dart';

// ignore: must_be_immutable
class GameSummary extends StatelessWidget {
  GameTeams? winner = GameTeams.none;
  final TeamName homeTeamName;
  final TeamName awayTeamName;
  final Score homeScore;
  final Score awayScore;
  GameSummary({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.winner,
    required this.homeScore,
    required this.awayScore,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const GameList()),
          (route) => route is GameList),

      child: Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: WinnerCard(
                        teamName: winner == GameTeams.home
                            ? homeTeamName
                            : awayTeamName,
                        team: winner == GameTeams.home
                            ? GameTeams.home
                            : GameTeams.away,
                        score: winner == GameTeams.away ? awayScore : homeScore,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      child: Opacity(
                        opacity: winner == GameTeams.none ? 1 : .5,
                        child: WinnerCard(
                          // Needs to be loosing team
                          teamName: winner == GameTeams.home
                              ? awayTeamName
                              : homeTeamName,
                          team: winner == GameTeams.home
                              ? GameTeams.away
                              : GameTeams.home,
                          score:
                              winner != GameTeams.home ? homeScore : awayScore,
                        ),
                      ),
                    )
                  ],
                )),
            Positioned(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                  Visibility(
                      visible: winner != GameTeams.none ? true : false,
                      maintainState: false,
                      child: Text('WINNER',
                          style: GoogleFonts.bebasNeue(
                              color: Colors.amberAccent,
                              fontSize: 48,
                              fontWeight: FontWeight.w800))),
                  Visibility(
                      visible: winner == GameTeams.none ? true : false,
                      maintainState: false,
                      child: Text('DRAW',
                          style: GoogleFonts.bebasNeue(
                              color: Colors.purple,
                              fontSize: 48,
                              fontWeight: FontWeight.w800))),
                  Visibility(
                      visible: winner != GameTeams.none ? true : false,
                      maintainState: false,
                      child: Text('LOSER',
                          style: GoogleFonts.bebasNeue(
                              color: Colors.amberAccent,
                              fontSize: 48,
                              fontWeight: FontWeight.w800))),
                ])))
          ],
        ),
      )),
    );
  }
}
