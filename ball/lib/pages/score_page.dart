import 'package:ball/state/models/game_enititty.dart';
import 'package:ball/state/notifier/game_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../state/provider/score_provider.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

int homeScore = 0;
int awayScore = 0;

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    final gameNotifier = GameProvider.of<GameNotifier>(context);

    return Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ScoreSideComponent(
                team: GameTeams.away,
                score: homeScore,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '00:00:00.0',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              child: ScoreSideComponent(
                team: GameTeams.home,
                score: awayScore,
              ),
            )
          ],
        ));
  }
}

class ScoreSideComponent extends StatefulWidget {
  final GameTeams team;
  int score;

  ScoreSideComponent({
    super.key,
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
          setState(() {
            widget.score += 2;
          });
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.team == GameTeams.away
                ? Colors.blueAccent
                : Colors.redAccent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                child: Text(
                  '${widget.score}',
                  style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w900),
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
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.score++;
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
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.score += 3;
                        });
                      },
                      child: Text('+3')),
                ],
              )
            ],
          ),
        ));
  }
}
