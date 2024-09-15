import 'package:ball/state/models/game_enititty.dart';
import 'package:flutter/material.dart';

class ScoreValueComponent extends StatelessWidget {
  final TeamName team;
  final Score score;
  const ScoreValueComponent({
    super.key, required this.team, required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(team,
              style: TextStyle(
                fontSize: 10,
              )),
          Center(
              child: Text(
            '$score',
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
