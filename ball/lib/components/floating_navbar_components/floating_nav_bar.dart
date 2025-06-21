import 'package:ball/components/bottom_sheets/create_game_bottom_sheet.dart';
import 'package:ball/components/floating_navbar_components/floating_navbar_items.dart';
import 'package:ball/components/floating_navbar_components/nav_bar_tile.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_bottom_sheet.dart';

// Nav UI Housing Component
class FloatingNavComponent extends ConsumerWidget {
  final void Function(int value) onTap;
  // final AppScreenState screenState;
  final int currentIndex;
  final List<NavBarItem> items;
  const FloatingNavComponent({
    this.currentIndex = 0,
    required this.onTap,
    required this.items,
    // required this.screenState,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.sizeOf(context).width,
      height: kBottomNavigationBarHeight,
      // color: Colors.blue,
      child: Center(
        child: MainNavUI(
          items: items,
          onTap: onTap,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}

// App Main Navigation UI State
class MainNavUI extends HookWidget {
  final List<NavBarItem> items;
  final void Function(int value) onTap;
  final int currentIndex;
  const MainNavUI({
    required this.items,
    required this.onTap,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xFFEDEDED),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(50, 21, 21, 21),
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            // Main Nav Items
            children: items.map((e) {
              return NavBarTile(
                onSelected: () => onTap(items.indexOf(e)),
                icon: e.icon,
                label: e.label,
                isSelected: currentIndex == items.indexOf(e) ? true : false,
              );
            }).toList(),
          ),
        ),

        // New Game FloatingButton
        AppButtonComponent(
          onTap: () => CreateGameBottomSheet().present(context),
          type: ButtonType.primary,
          icon: const Icon(FeatherIcons.plus),
        ),
      ],
    );
  }
}

class AppButtonComponent extends StatelessWidget {
  const AppButtonComponent({
    super.key,
    required this.onTap,
    this.label,
    required this.type,
    this.icon,
    this.trailingIcon,
    this.color,
  });

  final void Function() onTap;
  final Text? label;
  final ButtonType type;
  final Icon? icon;
  final Icon? trailingIcon;
  final Color? color;

  Widget _buildContent() {
    if (label != null && icon != null) {
      // Both label and icon are present, return a Row
      return Row(
        mainAxisSize: MainAxisSize.min, // Keep the row as small as possible
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          icon ??
              const SizedBox.shrink(), // Use ! because we've checked for null
          label!,
          trailingIcon ??
              const SizedBox.shrink(), // Use ! because we've checked for null
        ],
      );
    } else if (label != null) {
      // Only label is present
      return Center(heightFactor: 1, widthFactor: 1, child: label!);
    } else {
      // Only icon is present
      return Center(
        heightFactor: 1,
        widthFactor: 1,
        child: icon ?? trailingIcon ?? const SizedBox.shrink(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    Color splashColor;

    switch (type) {
      case ButtonType.primary:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.amber,
        );
        splashColor = Colors.amberAccent;
        break;

      case ButtonType.secondary:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // border: Border.all(color: Colors.black38),
          color: color ?? const Color(0xFFEDEDED),
        );
        splashColor = Colors.white70;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        type: MaterialType.button,
        child: InkWell(
          borderRadius: BorderRadius.circular(
            100,
          ), // Match container's border radius
          splashColor: splashColor,
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: decoration,
            child: _buildContent(),
          ),
        ),
      ),
    );
  }
}
