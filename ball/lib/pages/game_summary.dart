import 'package:ball/pages/score_page.dart';
import 'package:flutter/material.dart';

import '../state/notifier/game_notifier.dart';
import '../state/provider/score_provider.dart';

class GameSummary extends StatelessWidget {
  const GameSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final gameNotifier = GameProvider.of<GameNotifier>(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      content: Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('cancel')),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ScorePage(
                                homeTeamName: '', awayTeamName: '', scoreLimit: null, duration: null,
                                )));
                            },
                            child: Text('start game'))
                      ],
                    );
                  });
            },
            label: Text('New game')),
        body: gameNotifier.value.isEmpty
            ? Center(child: Text('empty data'))
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
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
                                  Flexible(child: ScoreValueComponent()),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Flexible(child: ScoreValueComponent()),
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
                  itemCount: gameNotifier.value.length,
                )));
  }
}

class ScoreValueComponent extends StatelessWidget {
  const ScoreValueComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('HomeTeam',
              style: TextStyle(
                fontSize: 10,
              )),
          Center(
              child: Text(
            '16',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          )),
        ],
      ),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.amberAccent, borderRadius: BorderRadius.circular(12)),
    );
  }
}
