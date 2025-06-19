import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_score_limit_notifier.g.dart';

// Game Score Limit Notifier
@riverpod
class GameScoreLimitNotifier extends _$GameScoreLimitNotifier {
  @override
  int? build() {return 0;}

  void scoreLimit(int? value) {
    state = value;
  }
}