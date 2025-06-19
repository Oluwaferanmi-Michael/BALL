import 'package:flutter/material.dart';

class Loadingindicator extends StatelessWidget {
  const Loadingindicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFffffff),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        width: 52,
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(16),
          color: Colors.amber,
        ),
      ),
    );
  }
}
