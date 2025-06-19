import 'package:flutter/material.dart';

class DrawerOptionsData {
  final String label;
  final IconData icon;
  final void Function() onTap;
  final String? subtext;

  const DrawerOptionsData({required this.label, required this.icon, required this.onTap, this.subtext});
}