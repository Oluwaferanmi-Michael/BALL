import 'dart:async';
import 'dart:convert';

import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';

import '../data/offline_storage_functions.dart';

// <Iterable<Game>>
// Game Notifier for CRUD Functions
class GameNotifier extends ChangeNotifier {
  GameNotifier() {
    //  Executed upon Constructor read
    readData();
  }

  Iterable<Game> _value = [];
  Iterable<Game> get value => _value;

  set value(newValue) {
    if (_value != value) {
      _value = newValue;
      notifyListeners();
    }
  }

  // Instsnce of Class containing Database Store Functions
  final _offlineStore = OfflineStoreFunctions.instance;

  Stream<void> readData() async* {
    final data = _offlineStore.watchDataChange();

    final controller = StreamController<Iterable<Game>>();

    data.listen((snapshot) {
      final game = snapshot
          .map((val) => Game.fromDatabase(data: jsonDecode(val)))
          .toList();

      controller.sink.add(game);
    });

    await for(final game in controller.stream){
      _value = game;
    }

    notifyListeners();
  }

  // Creating and saving new Game
  Future<void> saveGameData({required Game game}) async {
    await _offlineStore.insertData(gameData: game);
  }
}
