import 'dart:async';
import 'dart:convert';

import 'package:ball/state/data/offline_storage_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_enititty.dart';

part 'riverpod_game_notifier.g.dart';

@riverpod
class RiverpodGameNotifier extends _$RiverpodGameNotifier {
  @override
  Stream<List<Game>> build() async* {
    final gameStreamController = StreamController<List<Game>>();

    _offlineStorage.watchDataChange().listen(
      (snapshot) async {
      
      final value =
          snapshot.map((data) => Game.fromDatabase(data: jsonDecode(data))).toList();
      gameStreamController.add(value);
    }
  );


    await for (final i in gameStreamController.stream) {
      yield i;
    }

    ref.onDispose(() {
      gameStreamController.close();
      // gameDataSub.;
    });
  }

  final _offlineStorage = OfflineStoreFunctions.instance;

  Future<void> saveGameData({required Game game}) async {
    // final gameData = game.toDatabase();
    await _offlineStorage.insertData(gameData: game);
  }
}
