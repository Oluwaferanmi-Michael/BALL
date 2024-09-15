import 'package:ball/components/score_value_component.dart';
import 'package:ball/state/provider/game_provider.dart';

import 'package:flutter/material.dart';

import '../components/dialog.dart';
import '../state/notifier/game_notifier.dart';
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
    homeTeamNameController = TextEditingController();
    awayTeamNameController = TextEditingController();
    scoreLimitController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    homeTeamNameController.dispose();
    awayTeamNameController.dispose();
    scoreLimitController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameNotifier = GameNotifier();
    final data = GameProvider.of(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Dialogsss(context,
                  homeTeamNameController: homeTeamNameController,
                  awayTeamNameController: awayTeamNameController,
                  scoreLimitController: scoreLimitController);
            },
            label: Text('New game')),
        body: GameProvider(
          notifier: gameNotifier,
          child: Builder(
            builder:(context) {
            return data.isEmpty
                ? Center(child: Text('empty data'))
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        
                        return Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(child: ScoreValueComponent(team: data.elementAt(index).homeTeamName,  score: data.elementAt(index).homeTeamScore,)),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Flexible(child: ScoreValueComponent(team: data.elementAt(index).awayTeamName, score: data.elementAt(index).awayTeamScore,)),
                                      SizedBox(
                                        width: 12,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text('Duration: ')
                                ]));
                      },
                    ));
          }
        )
      )
    );
  }
}
