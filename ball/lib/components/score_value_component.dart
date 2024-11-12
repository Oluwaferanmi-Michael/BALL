import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';

class ScoreValueComponent extends StatelessWidget {
  final TeamName team;
  final Score score;
  const ScoreValueComponent({
    super.key,
    required this.team,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.amberAccent, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(team,
              style: const TextStyle(
                fontSize: 10,
              )),
          Center(
              child: Text(
            '$score',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          )),
        ],
      ),
    );
  }
}
