import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';

import '../data/offline_storage.dart';

// <Iterable<Game>>
class GameNotifier extends ChangeNotifier {
  GameNotifier() {
    _readData();
  }
  
  Iterable<Game> _value = [];
  Iterable<Game> get value => _value;
  set value(newValue) {
    if (_value != value) {
      _value = newValue;
      notifyListeners();
    }
  }

  Future<Iterable<Game>> _readData() async {
    final values = await _offlineStore.readAll();

    final result = values.map((data) => Game.fromDatabase(data: data)).toList();

    _value = result;
    notifyListeners();

    return result;
  }

  final _offlineStore = OfflineStore.instance;

  Future<void> saveGameData({required Game game}) async {
    final gameData = game.toDatabase();
    await _offlineStore.upload(gameData);
    notifyListeners();
  }
}
