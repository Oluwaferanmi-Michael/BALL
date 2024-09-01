import 'dart:convert';

import 'package:ball/state/models/game_enititty.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineStore {
  const OfflineStore(this.database);

  final SharedPreferencesAsync database;

  Future<void> create(Map<String, dynamic> gameData) async {
    final jsonString = json.encode(gameData);

    await database.setStringList(GameConstants.gameData, [jsonString]);
  }

  Future<List<Game>> read() async {
    try {
      final dataRead = await database.getStringList(GameConstants.gameData);

      var i;
      final List<Game> dataList = [];

      if (dataRead == null){
        return [];
      }

      for (i in dataRead) {
        final data = json.decode(i) as Map<String, dynamic>;
        final game = Game.fromDatabase(data: data);
        dataList.add(game);
      }

      return dataList;
    } catch (err) {
      return [];
    }
  }
}
