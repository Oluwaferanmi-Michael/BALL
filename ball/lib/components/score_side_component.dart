import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ScoreSideComponent extends StatefulWidget {
  final GameTeams team;
  final TeamName teamName;
  ValueNotifier<int> score;

  ScoreSideComponent({
    super.key,
    required this.teamName,
    required this.team,
    required this.score,
  });

  @override
  State<ScoreSideComponent> createState() => _ScoreSideComponentState();
}

class _ScoreSideComponentState extends State<ScoreSideComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          
            widget.score.value += 2;
          
        },
        child: Container(
          // padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(16),
            color: widget.team == GameTeams.away
                ? Colors.blueAccent
                : Colors.redAccent,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 24),
                Expanded(
                    child: SizedBox(
                  child: Text(
                    widget.teamName,
                    style: GoogleFonts.bebasNeue(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                )),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: widget.score,
                    builder: (context, value, child) {
                      return Text(
                        '${widget.score.value}',
                        style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 102,
                            fontWeight: FontWeight.w900),
                      );
                    }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 24)),
                          textStyle: WidgetStatePropertyAll(TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.score.value++;
                          });
                        },
                        child: Text('+1')),
                    SizedBox(
                      width: 24,
                    ),
                    TextButton(
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 24)),
                          textStyle: WidgetStatePropertyAll(TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          
                            widget.score.value += 3;
                          
                        },
                        child: Text('+3')),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
