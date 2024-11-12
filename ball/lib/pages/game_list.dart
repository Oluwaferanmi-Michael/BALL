import 'package:ball/components/score_value_component.dart';
// import 'package:ball/state/notifier/game_notifier.dart';
import 'package:ball/state/notifier/riverpod_game_notifier.dart';
import 'package:ball/state/provider/game_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../components/dialog.dart';
import '../global__parameters.dart';
// import '../state/notifier/game_notifier.dart';
// import '../state/provider/game_provider.dart';

class GameList extends StatefulWidget {
  const GameList({super.key});

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  late TextEditingController homeTeamNameController;
  late TextEditingController awayTeamNameController;
  late TextEditingController scoreLimitController;

  @override
  void initState() {
    // Initializing Controllers for team names
    homeTeamNameController = TextEditingController();
    awayTeamNameController = TextEditingController();
    scoreLimitController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // disposeing controllers on end of lifecycle
    homeTeamNameController.dispose();
    awayTeamNameController.dispose();
    scoreLimitController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final data = GameProvider.of(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            createGameDialog(context,
                homeTeamNameController: homeTeamNameController,
                awayTeamNameController: awayTeamNameController,
                scoreLimitController: scoreLimitController);
          },
          label: const Text('New Game'),
          icon: const Icon(Icons.sports_basketball_outlined),
        ),
        body: GameProvider(
            notifier: GlobalParameter.gameNotifier,
            child: Consumer(
              builder: (context, ref, child) {
                // if (context.mounted);
                final gameList = ref.watch(riverpodGameNotifierProvider);
                return gameList.when(
                    data: (data) {
                      return data.isEmpty
                          ? const Center(child: Text('empty data (riverpod)'))
                          : Padding(
                              padding: const EdgeInsets.all(12),
                              child: ListView.separated(
                                  itemCount: data.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 12,
                                      ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                      child:
                                                          ScoreValueComponent(
                                                    team: data
                                                        .elementAt(index)
                                                        .homeTeamName,
                                                    score: data
                                                        .elementAt(index)
                                                        .homeTeamScore,
                                                  )),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Flexible(
                                                      child:
                                                          ScoreValueComponent(
                                                    team: data
                                                        .elementAt(index)
                                                        .awayTeamName,
                                                    score: data
                                                        .elementAt(index)
                                                        .awayTeamScore,
                                                  )),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              data
                                                          .elementAt(index)
                                                          .scoreLimit !=
                                                      null
                                                  ? Text(
                                                      'ScoreLimit: ${data.elementAt(index).scoreLimit}')
                                                  : Text(
                                                      'Duration: ${data.elementAt(index).time}')
                                            ]));
                                  }));
                    },
                    error: (error, stck) =>
                        const Center(child: Text('Something Went Wrong')),
                    loading: () => const Center(
                        child: SizedBox(
                            width: 32, child: LinearProgressIndicator())));
              },
            )));
  }
}
