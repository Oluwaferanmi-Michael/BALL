import 'state/notifier/game_notifier.dart';


//  Globally Accessible Classes
class GlobalParameter {
  GlobalParameter._();

  static GameNotifier gameNotifier = GameNotifier();
}