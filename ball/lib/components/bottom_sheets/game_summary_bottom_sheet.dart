import 'package:ball/components/app_bottom_sheet.dart';
import 'package:ball/components/game_summary_component.dart';

import 'package:ball/state/models/game_enitity.dart';
import 'package:flutter/material.dart';

class GameSummaryBottomSheet extends AppBottomSheets {
  final Game game;
  GameSummaryBottomSheet({required this.game, required super.label})
    : super(ui: GameSummaryBottomSheetPresentation(game: game));
}

class GameSummaryBottomSheetPresentation extends StatelessWidget {
  final Game game;
  const GameSummaryBottomSheetPresentation({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GameSummaryComponent(game: game);
  }
}
