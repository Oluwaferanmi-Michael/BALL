import 'package:flutter/material.dart';

import '../pages/score_page.dart';
import '../state/models/game_enititty.dart';

Future<void> Dialogsss(
  BuildContext context, {
  required TextEditingController homeTeamNameController,
  required TextEditingController awayTeamNameController,
  required TextEditingController scoreLimitController,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        // GameConditions isDuration = GameConditions.timeLimit;
        Set<GameConditions> selected = {GameConditions.scoreLimit};

        return AlertDialog.adaptive(
          content: SingleChildScrollView(
              child: StatefulBuilder(
            builder: (context, StateSetter setState) => Container(
              padding: const EdgeInsets.all(12),
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
                        const Text('Game End Condition',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                        Transform.scale(
                            scale: 1,
                            child: SegmentedButton(
                              showSelectedIcon: false,
                              style: const ButtonStyle(),
                              onSelectionChanged: (value) {
                                setState(() {
                                  selected = value;
                                });
                              },
                              selected: selected,
                              segments: GameConditions.values
                                  .map((e) => ButtonSegment(
                                      value: e, label: Text(e.name)))
                                  .toList(),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: homeTeamNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: const Text('Home Name'),
                        hintStyle: const TextStyle(color: Colors.black54),
                        labelStyle: const TextStyle(color: Colors.black54),
                        hintText: 'Home'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: awayTeamNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: const Text('Away Name'),
                        hintStyle: const TextStyle(color: Colors.black54),
                        labelStyle: const TextStyle(color: Colors.black54),
                        hintText: 'Away'),
                  ),
                  const SizedBox(height: 12),
                  Visibility(
                    visible:
                        selected.first == GameConditions.none ? false : true,
                    maintainState: false,
                    child: TextField(
                      controller: scoreLimitController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffix: Text(
                              selected.first == GameConditions.timeLimit
                                  ? 'min'
                                  : 'pts '),
                          label: Text(selected.first.name),
                          hintStyle: const TextStyle(color: Colors.black54),
                          labelStyle: const TextStyle(color: Colors.black54),
                          hintText: selected.first.name),
                    ),
                  ),
                ],
              ),
            ),
          )),
          actions: [
            TextButton(
                onPressed: () {
                  if (awayTeamNameController.text.isNotEmpty){
                    awayTeamNameController.clear;}
                  if (homeTeamNameController.text.isNotEmpty){
                    homeTeamNameController.clear;}
                  if (scoreLimitController.text.isNotEmpty){
                    scoreLimitController.clear;}
                  Navigator.pop(context);
                },
                child: const Text('cancel')),
            TextButton(
                onPressed: () {
                  if (homeTeamNameController.text.isEmpty){
                    homeTeamNameController.text = 'Home';
                  }
                  if (awayTeamNameController.text.isEmpty){
                    awayTeamNameController.text = 'Away';
                  }

                  final homeName = homeTeamNameController.text;
                  final awayName = awayTeamNameController.text;


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScorePage(
                                homeTeamName: homeName,
                                awayTeamName: awayName,
                                scoreLimit:
                                    selected.first != GameConditions.scoreLimit
                                        ? null
                                        : int.parse(scoreLimitController.text),
                                duration:
                                    selected.first != GameConditions.timeLimit
                                        ? null
                                        : int.parse(scoreLimitController.text),
                              )));
                  if (awayTeamNameController.text.isNotEmpty){
                    awayTeamNameController.clear;}
                  if (homeTeamNameController.text.isNotEmpty){
                    homeTeamNameController.clear;}
                  if (scoreLimitController.text.isNotEmpty){
                    scoreLimitController.clear;
                    }
                },
                child: const Text('start game'))
          ],
        );
      });
}
