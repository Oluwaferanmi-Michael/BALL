import 'package:ball/state/models/game_constants.dart';

import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class OfflineStore {
  OfflineStore._init();

  static final OfflineStore instance = OfflineStore._init();

  static Database? db;

  Future<Database> get database async {
    if (db != null) return db!;
    db = await openGameDatabase();
    return db!;
  }

  Future<Database> openGameDatabase() async {
    final path = await getDatabasesPath();
    final database = await openDatabase(
        join(path, '${GameDatabase.gameDatabase} DESC'),
        onCreate: _createDatabase,
        version: 1);

    return database;
  }

  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    final createTableCommand = '''CREATE TABLE ${GameDatabase.gameTable}(
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
      )
      ''';

    
    await db.execute(createTableCommand);
  }

  Future<void> upload(Map<String, dynamic> gameData) async {
    final db = await instance.database;

    final id = await db.insert(GameDatabase.gameTable, gameData,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
  }

  Future<List<Map<String, dynamic>>> readAll() async {
    final db = await instance.database;
    try {
      final result = await db.query(
        GameDatabase.gameTable,
      );
      return result;
    } catch (err) {
      return [];
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
