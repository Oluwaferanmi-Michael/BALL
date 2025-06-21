import 'dart:async';
import 'dart:convert';

import 'package:ball/state/data/offline_storage/offline_storage_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_enitity.dart';

part 'offline_game_notifier.g.dart';

@riverpod
class OfflineGameNotifier extends _$OfflineGameNotifier {
  @override
  Stream<List<Game>> build() async* {
    final gameStreamController = StreamController<List<Game>>();

    final sub = _offlineStorage.watchDataChange().listen(
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
      sub.cancel();
    });
  }

  final _offlineStorage = OfflineStoreFunctions.instance;

  Future<void> saveGameData({required Map<String, dynamic> game}) async {
    // final gameData = game.toDatabase();
    await _offlineStorage.insertData(gameData: game);
  }
}
