import 'package:ball/state/models/game_constants.dart';
import 'package:ball/state/models/game_enitity.dart';

import '../models/offline_games_database.dart';

class OfflineStoreFunctions {
  // Constructor
  OfflineStoreFunctions._init();

  // Singleton Logic
  static final OfflineStoreFunctions instance = OfflineStoreFunctions._init();

  final appDatabase = AppDatabase();

  Future<void> insertData({required Map<String, dynamic> gameData}) async {
    final db = appDatabase;
    await appDatabase
        .into(db.offlineGames)
        .insert(
          OfflineGame(
            id: gameData[GameConstants.id],
            homeTeamScore: gameData[GameConstants.homeTeamScore],
            awayTeamScore: gameData[GameConstants.awayTeamScore],
            scoreLimit: gameData[GameConstants.scoreLimit] as ScoreLimit,
            awayTeamName: gameData[GameConstants.awayTeamName],
            homeTeamName: gameData[GameConstants.homeTeamName],
            winner: gameData[GameConstants.winner] ?? 'draw',
            winningTeam: gameData[GameConstants.winningTeam] as TeamName,
            gameDate: gameData[GameConstants.gameDate],
            duration: gameData[GameConstants.duration],
          ),
        );
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
