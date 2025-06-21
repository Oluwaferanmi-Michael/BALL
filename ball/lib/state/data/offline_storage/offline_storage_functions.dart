import 'package:ball/constants/data_constants.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/models/game_constants.dart';

import '../../models/offline_database.dart';

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

class UserProfileFunctions {
  // Constructor
  UserProfileFunctions._init();

  // Singleton Logic
  static final UserProfileFunctions instance = UserProfileFunctions._init();

  final db = AppDatabase();

  Future<void> createUser({required Map<String, dynamic> userData}) async {
    await db
        .into(db.userProfileData)
        .insert(
          UserProfileDataData(
            id: userData[UserDatabaseConstants.id],
            name: userData[UserDatabaseConstants.name],
            team: userData[UserDatabaseConstants.userTeam],
            position: userData[UserDatabaseConstants.position],
            role: userData[UserDatabaseConstants.role],
          ),
        );
  }

  Future<void> updateUser({required Map<String, dynamic> userData}) async {
    await db
        .update(db.userProfileData)
        .replace(
          UserProfileDataData(
            id: userData[UserDatabaseConstants.id],
            name: userData[UserDatabaseConstants.name],
            team: userData[UserDatabaseConstants.userTeam],
            position: userData[UserDatabaseConstants.position],
            role: userData[UserDatabaseConstants.role],
          ),
        );
  }

  void deleteUser() {
    db.delete(db.userProfileData).table;
    db.delete(db.offlineGames).table;
  }

  // Stream of data in Database returned in JSON String [List<String>] made possible by [.watch]
  Stream<List<String>> watchUserData() {
    final userData = db
        .select(db.userProfileData)
        .map((result) => result.toJsonString())
        .watch();

    return userData;
  }
}
