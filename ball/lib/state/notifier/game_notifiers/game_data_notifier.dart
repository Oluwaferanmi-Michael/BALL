import 'dart:async';
import 'dart:convert';

import 'package:ball/state/models/game_enitity.dart';
// import 'package:ball/state/notifier/away_score_notifier.dart';
// import 'package:ball/state/notifier/game_duration_notifier.dart';
// import 'package:ball/state/notifier/game_score_limit_notifier.dart';
// import 'package:ball/state/notifier/game_team_names_notifier.dart';
// import 'package:ball/state/notifier/game_time_notifier.dart';
// import 'package:ball/state/notifier/home_score_notifier.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/offline_storage_functions.dart';

// <Iterable<Game>>
// Game Notifier for CRUD Functions
part 'game_data_notifier.g.dart';

@riverpod
class GameDataNotifier extends _$GameDataNotifier {
  @override
  Stream<Iterable<Game>> build() async* {
    final data = _offlineStore.watchDataChange();

    final controller = StreamController<Iterable<Game>>();

    final sub = data.listen((snapshot) {
      final game = snapshot
          .map((val) => Game.fromDatabase(data: jsonDecode(val)))
          .toList();

      controller.sink.add(game);
    });

    await for (final game in controller.stream) {
      yield game;
    }

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
  }

  // Instsnce of Class containing Database Store Functions
  final _offlineStore = OfflineStoreFunctions.instance;

  // Creating and saving new Game
  Future<void> saveGameData({required Map<String, dynamic> game}) async {
    await _offlineStore.insertData(gameData: game);
  }

}
