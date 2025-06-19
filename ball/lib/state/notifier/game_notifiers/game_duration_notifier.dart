import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_duration_notifier.g.dart';

// Game Score Limit Notifier
@riverpod
class GameDurationNotifier extends _$GameDurationNotifier {
  @override
  int? build() {
    return 0;
  }

  void duration(int? value) {
    state = value;
  }
}
