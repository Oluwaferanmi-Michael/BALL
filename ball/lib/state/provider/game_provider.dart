// import 'package:ball/state/models/game_enititty.dart';
// import 'package:ball/state/notifier/game_notifier.dart';
// import 'package:flutter/material.dart';

// import '../../global__parameters.dart';

// class GameProvider extends InheritedNotifier<GameNotifier> {
//   GameProvider({
//     super.key, 
//     required super.child,
//     required GameNotifier notifier
//   }) : super(
//     notifier: GlobalParameter.gameNotifier
//   );

//   static Iterable<Game> of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<GameProvider>()
//         ?.notifier
//         ?.value ?? [];

//   }
// }
