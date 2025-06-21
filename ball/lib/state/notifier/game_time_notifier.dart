import 'dart:async';

import 'package:ball/state/models/utils/ext.dart';
import 'package:ball/state/models/game_enitity.dart';
import 'package:ball/state/notifier/game_notifiers/end_game_provider.dart';
import 'package:ball/state/notifier/game_sound_notifier.dart';

import 'package:ball/state/notifier/game_team_names_notifier.dart';
import 'package:ball/state/notifier/scores_notifier.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'game_time_notifier.g.dart';

@riverpod
class GameTimeNotifier extends _$GameTimeNotifier {
  @override
  Stream<String> build({required int? gameDuration}) {
    ref.onDispose(() {
      dispose();
    });

    if (gameDuration == null) {
      dispose();
      return const Stream.empty();
    } else {
      startTimer(duration: gameDuration);
    }
    return timerStreamController.stream;
  }

  final timerStreamController = StreamController<String>();

  PausableTimer? timer;

  void dispose() {
    timerStreamController.close();
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
      }
    }
  }

  void startTimer({required int duration}) {
    final time = Duration(minutes: duration);
    var timeInSeconds = time.inSeconds;

    timer = PausableTimer.periodic(const Duration(seconds: 1), () {
      timeInSeconds--;

      int newSeconds = (timeInSeconds % 60).floor();
      int newMinutes = ((timeInSeconds % 3600) / 60).floor();
      int newHour = (timeInSeconds / 3600).floor();

      String hour = newHour.doubleDigits;
      String minutes = newMinutes.doubleDigits;
      String seconds = newSeconds.doubleDigits;

      final timeElapsed = '$hour:$minutes:$seconds';
      timerStreamController.sink.add(timeElapsed);

      if (timeInSeconds <= 0) {
        ref.read(gameSoundNotifierProvider.notifier).buzzer();

        if (timer!.isActive) {
          dispose();
          final teamNames = ref.watch(gameTeamNameNotifierProvider);
          final scores = ref.watch(scoresNotifierProvider);

          final game = Game(
            homeTeamScore: scores.homeScore,
            awayTeamScore: scores.awayScore,
            duration: duration,
            awayTeamName: teamNames.away,
            homeTeamName: teamNames.home,
          );

          game.debugLog(message: 'game values - ${game.toString()}');
          ref.watch(endgameProvider(game: game));
        }
      }
    });

    // start timer
    timer!.start();
  }

  void pauseOrResumeTimer() {
    if (timer!.isActive) {
      timer!.pause();
    } else {
      timer!.start(); // Assumes timer.start() resumes a paused timer
    }
  }
}
