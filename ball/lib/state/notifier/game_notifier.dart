import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/offline_storage.dart';

class GameNotifier extends ValueNotifier<Iterable<Game>> {
  GameNotifier() : super([]) {
    void start() async {
      value = await offlineStore.read();
    }

    start();
  }

  final offlineStore = OfflineStore(SharedPreferencesAsync());

  Future<void> saveGameData({
    GameDuration? duration,
    ScoreLimit? scoreLimit,
    required TeamName homeTeamName,
    required TeamName awayTeamName,
    required bool draw,
    required TeamName? winner,
    required Score awayTeamScore,
    required Score homeTeamScore,
  }) async {
    final game = Game();

    final gameData = game.toDatabase(
      homeTeamScore: homeTeamScore,
      awayTeamScore: awayTeamScore,
      scoreLimit: scoreLimit,
      awayTeamName: awayTeamName,
      homeTeamName: homeTeamName,
      winner: draw ? GameTeams.none.name : winner!,
      time: duration,
      draw: draw,
    );

    await offlineStore.create(gameData);
  }
}
