import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'game_constants.dart';

part 'offline_games_database.g.dart';

// Drift Table

class OfflineGames extends Table {
  TextColumn get id => text().named('id')();
  IntColumn get homeTeamScore => integer().named('homeTeamScore')();
  IntColumn get awayTeamScore => integer().named('awayTeamScore')();
  IntColumn get scoreLimit => integer().named('scoreLimit')();
  IntColumn get duration => integer().named('duration')();
  TextColumn get awayTeamName => text().named('awayTeamName')();
  TextColumn get homeTeamName => text().named('homeTeamName')();
  TextColumn get winner => text().named('winner')();
  TextColumn get winningTeam => text().named('winningTeam')();
  DateTimeColumn get gameDate => dateTime().named('gameDate')();
}

@DriftDatabase(tables: [OfflineGames])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
// generate [filename].g.dart with build_runner makes the created Database from plural to singular (it's just convention)
  static QueryExecutor _openConnection() {
    return driftDatabase(name: GameDatabase.gameDatabaseName);
  }

  Future<void> insert(OfflineGame game) => into(offlineGames).insert(game);

  Future<List<OfflineGame>> get allGames => select(offlineGames).get();

}

