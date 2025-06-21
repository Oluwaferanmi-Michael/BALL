import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/notifier/game_notifiers/game_data_notifier.dart';
import 'package:ball/state/notifier/game_status_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/game_enitity.dart';

part 'end_game_provider.g.dart';

@riverpod
Future<void> endgame(Ref ref, {required Game game}) async {
  {
    ref
        .watch(gameStatusNotifierProvider.notifier)
        .setGameStatus(status: GameStatus.completed);

    final data = game.toDatabase();
    
    await ref.read(gameDataNotifierProvider.notifier).saveGameData(game: data);
  }
}
