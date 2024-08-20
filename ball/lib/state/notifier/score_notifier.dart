import 'package:flutter/material.dart';

class ScoreNotifier extends ValueNotifier<int> {
  ScoreNotifier(super.value);

  void incrementByTwo() => value = value += 2;
  void incrementByThree() => value = value += 3;

}