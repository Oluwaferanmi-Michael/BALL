import 'package:ball/state/models/game_enititty.dart';

import '../models/offline_games_database.dart';

class OfflineStoreFunctions {
  // Constructor
  OfflineStoreFunctions._init();

  // Singleton Logic
  static final OfflineStoreFunctions instance = OfflineStoreFunctions._init();

  final appDatabase = AppDatabase();

  Future<void> insertData({required Game gameData}) async {
    final db = appDatabase;
    await appDatabase.into(db.offlineGames).insert(OfflineGame(
        id: gameData.id,
        homeTeamScore: gameData.homeTeamScore,
        awayTeamScore: gameData.awayTeamScore,
        scoreLimit: gameData.scoreLimit as ScoreLimit,
        awayTeamName: gameData.awayTeamName,
        homeTeamName: gameData.homeTeamName,
        winner: gameData.winner ?? 'draw',
        winningTeam: gameData.winningTeam?.name as TeamName,
        time: gameData.time as GameDuration,
        gameDate: gameData.gameDate));
  }

  // Stream of data in Database returned in JSON String [List<String>] made possible by [.watch]
  Stream<List<String>> watchDataChange() {
    final db = appDatabase;

    final data = appDatabase
        .select(db.offlineGames)
        .map((result) => result.toJsonString())
        .watch();

    return data;
  }
}
