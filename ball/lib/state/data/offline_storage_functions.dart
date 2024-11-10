import 'package:ball/state/models/game_constants.dart';
import 'package:ball/state/models/game_enititty.dart';

import 'package:path/path.dart';
// import 'package:drift/drift.dart';

import 'package:sqflite/sqflite.dart';

import '../models/offline_games_database.dart';

class OfflineStoreFunctions {
  OfflineStoreFunctions._init();

  static final OfflineStoreFunctions instance = OfflineStoreFunctions._init();

  static Database? db;

  Future<Database> get database async {
    if (db != null) return db!;
    db = await openGameDatabase();
    return db!;
  }

  Future<Database> openGameDatabase() async {
    final path = await getDatabasesPath();
    final database = await openDatabase(join(path, GameDatabase.gameDatabase),
        onCreate: _createDatabase, version: 1);

    return database;
  }

  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    final createTableCommand = '''
      CREATE TABLE ${GameDatabase.gameTable}(
      ${GameDatabase.id} TEXT PRIMARY KEY, 
      ${GameDatabase.homeTeamName} TEXT, 
      ${GameDatabase.awayTeamName} TEXT, 
      ${GameDatabase.homeTeamScore} INTEGER, 
      ${GameDatabase.awayTeamScore} INTEGER, 
      ${GameDatabase.scoreLimit} INTEGER, 
      ${GameDatabase.time} INTEGER,
      ${GameDatabase.winner} TEXT,
      ${GameDatabase.winningTeam} TEXT,
      ${GameDatabase.gameDate} TEXT
      )''';

    await db.execute(createTableCommand);
  }

  Future<void> upload(Map<String, dynamic> gameData) async {
    final db = await instance.database;

    final id = await db.insert(GameDatabase.gameTable, gameData,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
  }

  Stream<List<Map<String, dynamic>>> readAll() async* {
    final db = await instance.database;
    // try {
    final result = await db.query(
      orderBy: GameDatabase.gameDate,
      GameDatabase.gameTable,
    );

    yield result;
    // } catch (err) {
    //   return [];
    // }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }

  final appDatabase = AppDatabase();

  Future<void> insertData({required Game gameData}) async {
    final db = appDatabase;
    await appDatabase.into(db.offlineGames).insert(
      OfflineGame(
        id: gameData.id, 
      homeTeamScore: gameData.homeTeamScore, 
      awayTeamScore: gameData.awayTeamScore, 
      scoreLimit: gameData.scoreLimit as ScoreLimit,
      awayTeamName: gameData.awayTeamName, 
      homeTeamName: gameData.homeTeamName, 
      winner: gameData.winner ?? 'draw',
      winningTeam: gameData.winningTeam?.name as TeamName, 
      time: gameData.time as GameDuration, 
      gameDate: gameData.gameDate)
    );
  }

  Stream<List<String>> watchDataChange() {
    final db = appDatabase;

    final data = appDatabase.select(db.offlineGames).map((result) => result.toJsonString()) .watch(); 

    return data;
  }
}
