import 'package:ball/state/models/game_team_names.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_team_names_notifier.g.dart';

@riverpod
class GameTeamNameNotifier extends _$GameTeamNameNotifier {
  @override
  TeamNames build() {
    return const TeamNames();
  }

  void updateTeamNames(TeamNames value) {
    state = value;
  }
}
