import 'dart:async';

import 'package:ball/pages/game_summary.dart';
import 'package:ball/state/models/game_enititty.dart';
import 'package:ball/state/notifier/game_notifier.dart';
import 'package:ball/state/provider/score_provider.dart';

import 'package:flutter/material.dart';

import '../components/score_side_component.dart';
import '../components/timer_or_limit_component.dart';

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

class _ScorePageState extends State<ScorePage> {
  late StreamController<String> timerStreamController;
  late Timer timer;

// Init State
  @override
  void initState() {
    timerStreamController = StreamController();
    timer = Timer(Duration(seconds: 1), () {});
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
          GameTeams winningTeam() {
            if (awayScore.value > homeScore.value) {
              return GameTeams.away;
            } else if (awayScore.value < homeScore.value) {
              return GameTeams.home;
            } else {
              return GameTeams.none;
            }
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GameSummary(
                        awayTeamName: widget.awayTeamName,
                        homeTeamName: widget.homeTeamName,
                        winner: winningTeam(),
                        awayScore: awayScore.value,
                        homeScore: homeScore.value,
                      )));
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

  ValueNotifier<int> homeScore = ValueNotifier<int>(0);
  ValueNotifier<int> awayScore = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    homeScore.addListener(() {
      if (widget.scoreLimit == null) {
        return;
      }

      final int limit = widget.scoreLimit!;

      if (homeScore.value >= limit) {
        if (timer.isActive) {
          timer.cancel();
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GameSummary(
                      awayTeamName: widget.awayTeamName,
                      homeTeamName: widget.homeTeamName,
                      winner: GameTeams.home,
                      awayScore: awayScore.value,
                      homeScore: homeScore.value,
                    )));
      }
    });

    awayScore.addListener(() {
      if (widget.scoreLimit == null) {
        return;
      }

      final int limit = widget.scoreLimit!;

      if (awayScore.value >= limit) {
        if (timer.isActive) {
          timer.cancel();
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GameSummary(
                      awayTeamName: widget.awayTeamName,
                      homeTeamName: widget.homeTeamName,
                      winner: GameTeams.away,
                      awayScore: awayScore.value,
                      homeScore: homeScore.value,
                    )));
      }
    });

    void stopGame() {
      if (timer.isActive) {
        timer.cancel();
      }

      GameTeams winningTeam() {
        if (awayScore.value > homeScore.value) {
          return GameTeams.away;
        } else if (awayScore.value < homeScore.value) {
          return GameTeams.home;
        } else {
          return GameTeams.none;
        }
      }

      // TeamName winnerName

      GameProvider.of<GameNotifier>(context).saveGameData(
          homeTeamName: widget.homeTeamName,
          awayTeamName: widget.awayTeamName,
          draw: winningTeam() == GameTeams.none ? true : false,
          winner: '',
          awayTeamScore: awayScore.value,
          homeTeamScore: homeScore.value);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GameSummary(
                    awayTeamName: widget.awayTeamName,
                    homeTeamName: widget.homeTeamName,
                    winner: winningTeam(),
                    awayScore: awayScore.value,
                    homeScore: homeScore.value,
                  )));
    }

    ;

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ScoreSideComponent(
                teamName: widget.awayTeamName,
                team: GameTeams.away,
                score: homeScore,
              ),
            ),
            Flexible(
              child: ScoreSideComponent(
                teamName: widget.homeTeamName,
                team: GameTeams.home,
                score: awayScore,
              ),
            )
          ],
        ),
        Positioned(
          bottom: (MediaQuery.sizeOf(context).height / 2) - 200,
          child: Column(
            children: [
              TimerOrLimitComponent(
                timerStreamController: timerStreamController,
                scoreLimit: widget.scoreLimit,
                duration: widget.duration,
              ),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.amberAccent),
                  ),
                  onPressed: () => stopGame(),
                  child: Text('Stop Game')),
            ],
          ),
        ),
      ],
    ));
  }
}
