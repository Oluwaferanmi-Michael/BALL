import 'package:ball/state/notifier/game_notifiers/game_data_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/game_enitity.dart';

part 'end_game_provider.g.dart';

@riverpod
void endgame(Ref ref, {required Game game}) {
  {
    

    final data = game.toDatabase();
    
    ref.read(gameDataNotifierProvider.notifier).saveGameData(game: data);
  }
}
