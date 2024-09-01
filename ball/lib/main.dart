import 'package:ball/pages/game_summary.dart';

import 'package:ball/state/notifier/game_notifier.dart';
import 'package:ball/state/provider/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent));
  runApp(
    GameProvider(
    notifier: GameNotifier(),
    child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: SafeArea(child: GameSummary())),
    );
  }
}
