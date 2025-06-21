import 'package:ball/state/models/enums/enums.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreValueComponent extends StatelessWidget {
  final TeamName team;
  final GameTeams gameTeams;
  const ScoreValueComponent({
    super.key,
    required this.team,
    required this.gameTeams,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Center(
          child: CircleAvatar(
            backgroundColor: gameTeams == GameTeams.home
                ? Colors.amberAccent
                : Colors.blueAccent,
          ),
        ),
        Text(
          team,
          style: GoogleFonts.bebasNeue(
            color: const Color.fromARGB(60, 43, 35, 44),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
