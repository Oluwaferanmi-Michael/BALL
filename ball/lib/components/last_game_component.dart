import 'package:ball/components/score_value_component.dart';
import 'package:ball/state/models/enums/enums.dart';

import 'package:ball/state/models/game_enitity.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LastGameDataWidget extends StatelessWidget {
  final String label;
  const LastGameDataWidget({
    super.key,
    required this.game,
    this.label = 'Last Game -',
  });

  final Game game;

  copyWith({String? label}) {
    return LastGameDataWidget(game: game, label: label ?? this.label);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label ${game.gameDate.weekday.intToDay()}, ${game.gameDate.month.intToMonth()} ${game.gameDate.day}',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0D0018),
              // const Color.fromARGB(255, 43, 35, 44),
            ),
          ),
          Row(
            // spacing: 42,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScoreValueComponent(
                team: game.homeTeamName,
                gameTeams: GameTeams.home,
              ),

              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${game.homeTeamScore} \t - \t ${game.awayTeamScore}',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 43, 35, 44),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          game.scoreLimit != 0
                              ? 'Score Limit'
                              : 'Game Duration',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 43, 35, 44),
                          ),
                        ),
                        Text(
                          game.scoreLimit != 0
                              ? '${game.scoreLimit} pts'
                              : '${game.duration}:00 min',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 43, 35, 44),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ScoreValueComponent(
                team: game.awayTeamName,
                gameTeams: GameTeams.away,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
