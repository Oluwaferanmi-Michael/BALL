import 'package:flutter/material.dart';

import '../pages/score_page.dart';
import '../state/models/game_enititty.dart';

Future<void> Dialogsss(BuildContext context, {
  required TextEditingController homeTeamNameController,
  required TextEditingController awayTeamNameController,
  required TextEditingController scoreLimitController,
}) {
    return showDialog(
        context: context,
        builder: (context) {

          // GameConditions isDuration = GameConditions.timeLimit;
          Set<GameConditions> _selected = {GameConditions.scoreLimit};

          


          return AlertDialog.adaptive(
            content: SingleChildScrollView(
                child: StatefulBuilder(
              builder: (context, StateSetter setState) => Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Game End Condition',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 24,
                          ),
                          Transform.scale(
                              scale: 1,
                              child: SegmentedButton(
                                showSelectedIcon: false,
                                style: ButtonStyle(),
                                onSelectionChanged: (value) {
                                  setState(() {
                                    _selected = value;
                          
                                  });
                                },
                                selected: _selected,
                                segments: GameConditions.values
                                    .map((e) => ButtonSegment(
                                        value: e,
                                        label: Text(e.name)))
                                    .toList(),
                              )
                              
                              )
                        ],
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
                          labelStyle: TextStyle(color: Colors.black54),
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
                          labelStyle: TextStyle(color: Colors.black54),
                          hintText: 'Away'),
                    ),
                    SizedBox(height: 12),
                    Visibility(
                      visible:
                          _selected.first == GameConditions.none ? false : true,
                      maintainState: false,
                      child: TextField(
                        controller: scoreLimitController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffix: Text(_selected.first == GameConditions.timeLimit ? 'min' : 'pts '),
                            label: Text(_selected.first.name),
                            hintStyle: TextStyle(color: Colors.black54),
                            labelStyle: TextStyle(color: Colors.black54),
                            hintText: _selected.first.name),
                      ),
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
                  final homeName = homeTeamNameController.text.isEmpty
                        ? 'Home'
                        : homeTeamNameController.text;
                    final awayName = awayTeamNameController.text.isEmpty
                        ? 'Away'
                        : awayTeamNameController.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScorePage(
                                  homeTeamName: homeName,
                                  awayTeamName: awayName,
                                  scoreLimit: _selected.first != GameConditions.scoreLimit
                                      ? null
                                      : int.parse(scoreLimitController.text),
                                  duration: _selected.first != GameConditions.timeLimit
                                      ? null
                                      : int.parse(scoreLimitController.text),
                                )));
                  },
                  child: Text('start game'))
            ],
          );
        });
  }