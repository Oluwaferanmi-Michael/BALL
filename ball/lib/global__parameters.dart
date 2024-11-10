import 'state/notifier/game_notifier.dart';

class GlobalParameter {
  GlobalParameter._();

  static GameNotifier gameNotifier = GameNotifier();
}