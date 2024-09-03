import 'package:ball/pages/game_list.dart';
import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';

import '../components/winner_card.dart';

class GameSummary extends StatelessWidget {
  final GameTeams winner;
  final TeamName homeTeamName;
  final TeamName awayTeamName;
  final Score homeScore;
  final Score awayScore;
  const GameSummary({
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
      onPopInvokedWithResult: (value, _) {
        return Navigator.popUntil(context, (value) {
          MaterialPageRoute(builder: (context) => GameList());
          return true;
        });
      },
      child: Scaffold(
          body: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Opacity(
                      opacity: winner == GameTeams.home ? 1 : .5,
                      child: WinnerCard(
                        teamName: homeTeamName,
                        team: winner == GameTeams.home
                            ? GameTeams.home
                            : GameTeams.away,
                        score: winner == GameTeams.home ? homeScore : awayScore,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Flexible(
                    child: Opacity(
                      opacity: winner == GameTeams.away ? .5 : 1,
                      child: WinnerCard(
                        teamName: homeTeamName,
                        team: winner == GameTeams.away
                            ? GameTeams.home
                            : GameTeams.away,
                        score: winner == GameTeams.home ? homeScore : awayScore,
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
