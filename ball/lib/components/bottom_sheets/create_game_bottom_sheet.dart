import 'package:ball/components/app_bottom_sheet.dart';
import 'package:ball/components/floating_navbar_components/floating_nav_bar.dart';
import 'package:ball/pages/score_page.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:ball/state/models/game_enitity.dart';
import 'package:ball/state/models/game_team_names.dart';
import 'package:ball/state/notifier/game_notifiers/game_duration_notifier.dart';
import 'package:ball/state/notifier/game_notifiers/game_score_limit_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateGameBottomSheet extends AppBottomSheets {
  CreateGameBottomSheet({
    super.ui = const CreateGamePresentation(),
    super.label = 'Game Win Conditions',
  });
}

class CreateGamePresentation extends HookConsumerWidget {
  const CreateGamePresentation({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeTeamNameController = useTextEditingController();
    final awayTeamNameController = useTextEditingController();
    final scoreLimitController = useTextEditingController();
    final selected = useState(GameConditions.timeLimit);

    void clearControllers() {
      if (awayTeamNameController.text.isNotEmpty) {
        awayTeamNameController.clear;
      }
      if (homeTeamNameController.text.isNotEmpty) {
        homeTeamNameController.clear;
      }
      if (scoreLimitController.text.isNotEmpty) {
        scoreLimitController.clear;
      }
    }

    return Container(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              // spacing: 24,
              children: [
                Transform.scale(
                  scale: .8,
                  // Button to Pick gamestyle options
                  child: SegmentedButton<GameConditions>(
                    expandedInsets: const EdgeInsets.all(8),
                    showSelectedIcon: false,
                    style: ButtonStyle(
                      textStyle: WidgetStatePropertyAll<TextStyle>(
                        GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onSelectionChanged: (value) {
                      selected.value = value.first;
                    },
                    selected: {selected.value},
                    segments: GameConditions.values
                        .map(
                          (e) => ButtonSegment(value: e, label: Text(e.name)),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 12),
          TextField(
            controller: homeTeamNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                'Home Team',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.black54,
              ),
              labelStyle: const TextStyle(color: Colors.black54),
              hintText: 'Home',
            ),
          ),
          // const SizedBox(height: 12),
          TextField(
            controller: awayTeamNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                'Away Team',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.black54,
              ),
              labelStyle: const TextStyle(color: Colors.black54),
              hintText: 'Away',
            ),
          ),
          // const SizedBox(height: 12),
          Visibility(
            visible: selected.value == GameConditions.none ? false : true,
            maintainState: false,
            child: TextField(
              controller: scoreLimitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffix: Text(
                  // If selected item is Time Limit display [min]
                  // If selected item is Score Limit display [pts]
                  selected.value == GameConditions.timeLimit ? 'min' : 'pts ',
                ),
                label: Text(selected.value.name),
                hintStyle: const TextStyle(color: Colors.black54),
                labelStyle: const TextStyle(color: Colors.black54),
                hintText: selected.value.name,
              ),
            ),
          ),

          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              AppButtonComponent(
                onTap: () {
                  clearControllers();
                  Navigator.pop(context);
                },
                label: const Text('cancel'),
                type: ButtonType.secondary,
              ),
              Expanded(
                child: AppButtonComponent(
                  onTap: () {
                    try {
                      if (homeTeamNameController.text.isEmpty) {
                        homeTeamNameController.text = 'Home';
                      }
                      if (awayTeamNameController.text.isEmpty) {
                        awayTeamNameController.text = 'Away';
                      }

                      final homeName = homeTeamNameController.text;
                      final awayName = awayTeamNameController.text;

                      int intValue;

                      if (selected.value != GameConditions.none) {
                        intValue = int.parse(scoreLimitController.text);

                        // check scoreLimitController for data and assign .text to
                        final gameCondition = selected.value;
                        final scoreLimit =
                            gameCondition == GameConditions.scoreLimit
                            ? intValue
                            : null;
                        final duration =
                            gameCondition == GameConditions.timeLimit
                            ? intValue
                            : null;

                        ref
                            .watch(gameScoreLimitNotifierProvider.notifier)
                            .scoreLimit(scoreLimit);
                        ref
                            .watch(gameDurationNotifierProvider.notifier)
                            .duration(duration);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScorePage(
                              teamNames: TeamNames(
                                home: homeName,
                                away: awayName,
                              ),
                              scoreLimit: scoreLimit,
                              duration: duration,
                            ),
                          ),
                        );

                        clearControllers();
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScorePage(
                            teamNames: TeamNames(
                              home: homeName,
                              away: awayName,
                            ),
                            scoreLimit: null,
                            duration: null,
                          ),
                        ),
                      );

                      // Clear Controllers
                      awayTeamNameController.clear;
                      homeTeamNameController.clear;
                      scoreLimitController.clear;
                    } catch (e) {
                      e.debugLog();
                    }
                  },
                  label: const Text('start game'),
                  type: ButtonType.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
