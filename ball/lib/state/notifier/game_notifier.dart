import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';

class GameNotifier extends ValueNotifier<Game> {
  GameNotifier() : super(Game.none()) {}

  void increment({
    required GameTeams gameTeam,
    required Score score,
  }) {
    if (gameTeam == GameTeams.home) {
    // value = value.copyWith()..homeTeamScore += score;  
    } else {
      
    }
  }
}
