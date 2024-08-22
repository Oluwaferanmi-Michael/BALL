import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';

class ScoreNotifier extends ValueNotifier<Game> {
  ScoreNotifier() : super(Game.none()) {}

  void incrementByTwo() {}

  void incrementByOne() {}

  void incrementByThree({
    required GameTeams gameTeam,
    required Score score,
  }) {
    // value = value.copyWith()..homeTeamScore += score;
  }
}
