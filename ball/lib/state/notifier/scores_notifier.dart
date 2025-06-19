import 'package:ball/state/models/scores.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scores_notifier.g.dart';

@riverpod
class ScoresNotifier extends _$ScoresNotifier {
  @override
  Scores build() {
    return Scores.empty();
  }

  void addScores(Scores scores) {
    state = scores;
  }
}
