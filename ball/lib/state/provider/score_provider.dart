import 'package:flutter/material.dart';

class ScoreProvider<T extends Listenable> extends InheritedNotifier<T> {
  ScoreProvider({
    required super.child,
    required super.notifier,
  });

  static T of<T extends Listenable>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ScoreProvider<T>>();

    if (provider == null) {
      throw Exception('No Provider Found in context');
    }

    final notifier = provider.notifier;

    if(notifier == null){
throw Exception('No Notifier Found in Provider');
    }

    return notifier;
  }
}
