import 'dart:async';

import 'package:ball/pages/game_summary.dart';
import 'package:ball/state/models/game_enititty.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScorePage extends StatefulWidget {
  final GameDuration? duration;
  final ScoreLimit? scoreLimit;
  final TeamName homeTeamName;
  final TeamName awayTeamName;
  const ScorePage(
      {super.key,
      this.duration,
      this.scoreLimit,
      required this.homeTeamName,
      required this.awayTeamName});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

int homeScore = 0;
int awayScore = 0;

class _ScorePageState extends State<ScorePage> {
  late StreamController<String> timerStreamController;
  late Timer timer;
  @override
  void initState() {
    timerStreamController = StreamController();
    super.initState();

    timerPer(widget.duration);
  }

  void timerPer(int? time) async {
    if (time == null) {
      return;
    }

    String? duration = '00:00:00.0';

    Duration gameDuration = Duration(minutes: time);

    int durationInSeconds = gameDuration.inSeconds;

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (durationInSeconds <= 0) {
          timer.cancel();
        } else {
          durationInSeconds--;
          final newSeconds = (durationInSeconds % 60).floor().toString();
          final newMinutes =
              ((durationInSeconds % 3600) / 60).floor().toString();
          final newHour = (durationInSeconds / 3600).floor().toString();

          duration = '$newHour:$newMinutes:$newSeconds';
          timerStreamController.sink.add(duration!);
        }
      },
    );
  }

  @override
  void dispose() {
    timerStreamController.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            StreamBuilder<String?>(
                stream: timerStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Display a loading indicator when waiting for data.
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Display an error message if an error occurs.
                  } else if (!snapshot.hasData) {
                    return Text(
                        'No data available'); // Display a message when no data is available.
                  } else {
                    return Text(
                      '${snapshot.data}',
                      style: TextStyle(fontSize: 24),
                    );
                  }
                }),
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

// ignore: must_be_immutable
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
              Expanded(
                  child: SizedBox(
                child: Text(widget.team.name),
              )),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (xontext) => GameSummary()));
                      },
                      child: Text('summary')),
                ],
              )
            ],
          ),
        ));
  }
}
