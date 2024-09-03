import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WinnerCard extends StatefulWidget {
  final GameTeams team;
  final TeamName teamName;
  final int score;

  const WinnerCard({
    super.key,
    required this.teamName,
    required this.team,
    required this.score,
  });

  @override
  State<WinnerCard> createState() => WinnerCardState();
}

class WinnerCardState extends State<WinnerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: widget.team == GameTeams.away
            ? Colors.blueAccent
            : Colors.redAccent,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 24),
            Text(
              widget.teamName,
              style: GoogleFonts.bebasNeue(
                  color: Colors.white70,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '${widget.score}',
                  style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 100,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
