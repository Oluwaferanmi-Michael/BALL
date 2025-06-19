

// import 'dart:async';

// import 'package:ball/state/models/enums/enums.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'app_notifier.g.dart';

// @riverpod
// class AppScreenStateNotifier extends _$AppScreenStateNotifier{

//   @override
//   Stream<AppScreenState> build() {

//     final controller = StreamController<AppScreenState>();

//     return controller.stream;
//   }


//   void _changeState(AppScreenState screen) {
//     state = AsyncValue.data(screen);
//   }
//   void gameState(AppScreenState screen) {
//     _changeState(AppScreenState.game);
//   }
//   void mainNavState(AppScreenState screen) {
//     _changeState(AppScreenState.mainNav);
//   }
  
  
// }