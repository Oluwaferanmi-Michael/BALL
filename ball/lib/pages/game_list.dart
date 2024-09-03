import 'package:ball/pages/score_page.dart';
import 'package:flutter/material.dart';

import '../state/notifier/game_notifier.dart';
import '../state/provider/score_provider.dart';

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

  bool isDuration = true;

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
                      content: SingleChildScrollView(
                          child: StatefulBuilder(
                        builder: (context, StateSetter setState) => Container(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDuration = !isDuration;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Game End Condition',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(isDuration == true
                                              ? 'Time Limit'
                                              : 'Score Limit'),
                                          Transform.scale(
                                            scale: .6,
                                            child: Switch.adaptive(
                                                inactiveThumbColor:
                                                    Colors.amber,
                                                activeColor: Colors.purple,
                                                value: isDuration,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isDuration = value;
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: homeTeamNameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    label: Text('Home Name'),
                                    hintStyle: TextStyle(color: Colors.black54),
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    hintText: 'Home'),
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: awayTeamNameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    label: Text('Away Name'),
                                    hintStyle: TextStyle(color: Colors.black54),
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    hintText: 'Away'),
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: scoreLimitController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    helper: Text('required'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffix: Text(isDuration ? 'min' : 'pts '),
                                    label: Text(isDuration
                                        ? 'Time Limit'
                                        : 'Score Limit'),
                                    hintStyle: TextStyle(color: Colors.black54),
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    hintText: isDuration
                                        ? 'Time Limit'
                                        : 'Score Limit'),
                              ),
                            ],
                          ),
                        ),
                      )),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('cancel')),
                        TextButton(
                            onPressed: () {
                              if (scoreLimitController.text.isEmpty) {
                                return;
                              }

                              final homeName =
                                  homeTeamNameController.text.isEmpty
                                      ? 'Home'
                                      : homeTeamNameController.text;
                              final awayName =
                                  awayTeamNameController.text.isEmpty
                                      ? 'Away'
                                      : awayTeamNameController.text;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScorePage(
                                            homeTeamName: homeName,
                                            awayTeamName: awayName,
                                            scoreLimit: isDuration
                                                ? null
                                                : int.parse(
                                                    scoreLimitController.text),
                                            duration: isDuration
                                                ? int.parse(
                                                    scoreLimitController.text)
                                                : null,
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
