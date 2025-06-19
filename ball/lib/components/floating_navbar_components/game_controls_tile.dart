import 'package:flutter/material.dart';

class GameControlsItem{
  final IconData icon;
  final String label;
  final Color? color;
  final void Function() function;

  const GameControlsItem({
    this.color,
    required this.icon,
    required this.label,
    required this.function,
  });
}
