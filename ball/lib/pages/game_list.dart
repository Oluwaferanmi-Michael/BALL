import 'package:ball/components/app_bottom_sheet.dart';
import 'package:ball/components/bottom_sheets/create_game_bottom_sheet.dart';
import 'package:ball/components/bottom_sheets/game_summary_bottom_sheet.dart';
import 'package:ball/components/floating_navbar_components/floating_nav_bar.dart';
import 'package:ball/components/last_game_component.dart';
import 'package:ball/components/loading_indicator.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/models/game_enitity.dart';
import 'package:ball/state/notifier/game_notifiers/game_data_notifier.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameList extends HookConsumerWidget {
  const GameList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameList = ref.watch(gameDataNotifierProvider);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: Builder(
      //     builder: (context) {
      //       return IconButton(
      //         icon: const Icon(FeatherIcons.menu, size: 18),
      //         onPressed: () => Scaffold.of(context).openDrawer(),
      //       );
      //     },
      //   ),
      // ),
      // drawer: const Drawer(
      //   // backgroundColor: Colors.transparent,
      //   child: DrawerUIComponent(),
      // ),
      body: gameList.when(
        data: (data) {
          return data.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      const Text('no games yet'),
                      AppButtonComponent(
                        onTap: () => CreateGameBottomSheet().present(context),
                        type: ButtonType.primary,
                        label: const Text('new game'),
                        icon: const Icon(FeatherIcons.plus),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    spacing: 12,
                    children: [
                      LastGameDataWidget(game: data.last),
                      Flexible(
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Previous Games',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 43, 35, 44),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  bottom: kBottomNavigationBarHeight + 10,
                                ),
                                child: ListView.separated(
                                  clipBehavior: Clip.antiAlias,

                                  shrinkWrap: true,
                                  itemCount: data.length > 1
                                      ? data.length - 1
                                      : 0,
                                  separatorBuilder: (context, index) =>
                                      Transform.scale(
                                        scale: .5,
                                        child: Divider(
                                          radius: BorderRadius.circular(12),

                                          // indent: 20,
                                          // endIndent: 400,
                                          height: 16,
                                          color: Colors.black26,
                                        ),
                                      ),
                                  itemBuilder: (context, index) {
                                    // Skip the last (most recent) game, which is shown above
                                    int newIndex = data.length - 2 - index;
                                    return GameScoreDataWidget(
                                      game: data.elementAt(newIndex),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
        error: (error, stck) =>
            const Center(child: Text('Something Went Wrong')),
        loading: () => const Loadingindicator(),
      ),
    );
  }
}

class GameScoreDataWidget extends StatelessWidget {
  const GameScoreDataWidget({required this.game, super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          GameSummaryBottomSheet(game: game, label: '').present(context),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   'Last Game - ${game.gameDate.weekday.intToDay()}, ${game.gameDate.month.intToMonth()} ${game.gameDate.day}',
            //   style: GoogleFonts.poppins(
            //     fontSize: 11,
            //     fontWeight: FontWeight.w600,
            //     color: const Color.fromARGB(255, 43, 35, 44),
            //   ),
            // ),
            Row(
              spacing: 42,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 4,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${game.homeTeamScore} \t\t : \t\t ${game.awayTeamScore}',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 43, 35, 44),
                      ),
                    ),
                    Text(
                      game.scoreLimit != 0
                          ? '${game.scoreLimit} pts'
                          : '${game.duration}:00 min',
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 43, 35, 44),
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 4,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
