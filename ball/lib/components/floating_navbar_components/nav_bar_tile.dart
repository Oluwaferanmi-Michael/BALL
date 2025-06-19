import 'package:flutter/material.dart';

class NavBarTile extends StatelessWidget {
  final void Function() onSelected;
  final bool isSelected;
  final IconData icon;
  final String label;
  const NavBarTile(
      {required this.onSelected,
      required this.icon,
      required this.label,
      required this.isSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 3),
          padding:
              isSelected ? const EdgeInsets.all(8) : const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFCDCDCD) : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(spacing: 8, children: [
            Icon(
              icon,
              size: 16,
            ),
            Visibility(
                maintainSize: false,
                visible: isSelected ? true : false,
                maintainInteractivity: false,
                maintainState: false,
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 12),
                ))
          ])),
    );
  }
}


class GameScreenTile extends StatelessWidget {
  final void Function() onSelected;
  
  final IconData icon;
  final String label;
  final Color? color;
  const GameScreenTile(
      { this.color,
        required this.onSelected,
      required this.icon,
      required this.label,
      
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 3),
          padding:
              const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color ??  const Color(0xFFCDCDCD),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(spacing: 8, children: [
            Icon(
              icon,
              size: 16,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            )
          ])),
    );
  }
}



