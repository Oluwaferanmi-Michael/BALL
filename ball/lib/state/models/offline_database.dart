import 'package:ball/constants/data_constants.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'offline_database.g.dart';

// Game Table
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

// User Table
class UserProfileData extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('userName')();
  TextColumn get team => text().named('userTeam')();
  TextColumn get position => text().named('position')();
  TextColumn get role => text().named('role')();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(tables: [OfflineGames, UserProfileData])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;
  // generate [filename].g.dart with build_runner makes the created Databas 
  static QueryExecutor _openConnection() {
    return driftDatabase(name: DataConstants.databaseName);
  }
}
