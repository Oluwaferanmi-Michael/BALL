import 'package:ball/state/notifier/score_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../state/provider/score_provider.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    final scoreNotifier = ScoreProvider.of<ScoreNotifier>(context);
    
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: GestureDetector(
              onTap: () {
                scoreNotifier.incrementByTwo();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blue,
                ),
                child: Center(
                    child: Text(
                  '${scoreNotifier.value}',
                  style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w900),
                )),
              ),
            )),
            SizedBox(
              height: 16,
            ),
            Flexible(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.redAccent,
              ),
              child: Center(
                  child: Text(
                'data',
                style: GoogleFonts.acme(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w900),
              )),
            ))
          ],
        ));
  }
}
