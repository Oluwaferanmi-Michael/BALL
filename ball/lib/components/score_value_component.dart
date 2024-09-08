import 'package:flutter/material.dart';

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
