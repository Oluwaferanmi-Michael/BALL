import 'package:ball/state/models/game_enititty.dart';
import 'package:ball/state/notifier/game_notifier.dart';
import 'package:flutter/material.dart';

class GameProvider extends InheritedNotifier<GameNotifier> {
  GameProvider({
    required Widget child,
    required GameNotifier notifier
  }) : super(
    child: child,
    notifier: GameNotifier()
  );

  static Iterable<Game> of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GameProvider>()
        ?.notifier
        ?.value ?? [];

  }
}
