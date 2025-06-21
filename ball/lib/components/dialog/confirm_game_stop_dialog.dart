import 'package:ball/components/dialog/dialogs.dart';
import 'package:ball/components/floating_navbar_components/floating_nav_bar.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:flutter/material.dart';

class ConfirmGameStopDialog extends AppDialogs {
  final BuildContext context;
  void Function()? action;
  ConfirmGameStopDialog(this.context, {this.action})
    : super(
        actions: [
          AppButtonComponent(
            label: 'cancel',
            onTap: () => Navigator.pop(context, false),
            type: ButtonType.secondary,
          ),

          AppButtonComponent(
            label: 'leave game',
            type: ButtonType.primary,
            onTap: () {
              action;
              Navigator.pop(context, true);
            },
          ),
        ],
        description:
            'are you sure you want to leave the game, your data may not be saved ?',
        label: 'Stop game',
      );
}
