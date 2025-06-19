import 'package:ball/state/models/enums/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_status_notifier.g.dart';

@riverpod
class GameStatusNotifier extends _$GameStatusNotifier {
  @override
  GameStatus build() {
    return GameStatus.notStarted;
  }

  void setGameStatus({required GameStatus status}) {
    state = status;
  }
}
