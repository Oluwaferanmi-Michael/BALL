


import 'package:flutter/material.dart';

@immutable
class DataConstants {
  const DataConstants._();

  static const id = 'id';
  static const name = 'name';
  static const position = 'postion';
  static const role = 'role';
  static const databaseName = 'ballOfflineDatabase';
}

class UserDatabaseConstants {
  const UserDatabaseConstants._();

  static const id = 'id';
  static const name = 'name';
  // static const gameData = 'gameData';
  static const databaseName = 'userProfileTable.db';
  static const position = DataConstants.position;
  static const role = 'role';
  static const userTeam = 'userTeam';
  static const gameTable = 'games';
}