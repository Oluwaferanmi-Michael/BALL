import 'dart:async';

import 'package:ball/pages/game_summary.dart';
import 'package:ball/state/models/game_enititty.dart';

import 'package:flutter/material.dart';

import '../components/score_side_component.dart';
import '../components/timer_or_limit_component.dart';
import '../global__parameters.dart';

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

      GameConditions get _scoreLimit => scoreLimit != null ? GameConditions.scoreLimit : GameConditions.timeLimit ;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  late StreamController<String> timerStreamController;
  late Timer timer;
  late ValueNotifier<int> awayScore;
  late ValueNotifier<int> homeScore;

// Init State
  @override
  void initState() {
    timerStreamController = StreamController();
    timer = Timer(const Duration(seconds: 1), () {});

    homeScore = ValueNotifier<int>(0);
    awayScore = ValueNotifier<int>(0);

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
      const Duration(seconds: 1),
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

    homeScore.dispose();
    awayScore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> stopGame() async {
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

      final winningT = winningTeam();

      String win(GameTeams condition) {
        if (winningT == GameTeams.home) {
          return widget.homeTeamName;
        } else if (winningT == GameTeams.away) {
          return widget.awayTeamName;
        } else {
          return 'none';
        }
      }

      final aScoreValue = awayScore.value;
      final hScoreValue = homeScore.value;

      final gameNotifier = GlobalParameter.gameNotifier;

      await gameNotifier.saveGameData(
          game: Game(
        awayTeamName: widget.awayTeamName,
        homeTeamName: widget.homeTeamName,
        awayTeamScore: aScoreValue,
        homeTeamScore: hScoreValue,
        scoreLimit: widget.scoreLimit ?? 0,
        time: widget.duration ?? 0,
        winner: win(winningT),
        winningTeam: winningT,
      ));

      if (context.mounted) {
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
    }

    homeScore.addListener(() async {
      if (widget.scoreLimit == null) {
        return;
      }

      final int limit = widget.scoreLimit!;

      if (homeScore.value >= limit) {
        await stopGame();
      }
    });

    awayScore.addListener(() async {
      if (widget.scoreLimit == null) {
        return;
      }

      final int limit = widget.scoreLimit!;
      // print(limit);

      if (awayScore.value >= limit) {
        await stopGame();
      }
    });

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
          child: SizedBox(
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
                    onPressed: () async => await stopGame(),
                    child: const Text('Stop Game')),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
