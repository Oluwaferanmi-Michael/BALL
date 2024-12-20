import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreValueComponent extends StatelessWidget {
  final TeamName team;
  final Score score;
  const ScoreValueComponent({
    super.key,
    required this.team,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
            child: Text(
          '$score',
          style:
              GoogleFonts.bebasNeue(
                // color: ,
                fontSize: 64,
                fontWeight: FontWeight.w800),
        )),
        Text(team,
            style: GoogleFonts.bebasNeue(
                color: const Color.fromARGB(30, 43, 35, 44),
                fontSize: 16,
                fontWeight: FontWeight.w800)),
      ],
    );
  }
}
