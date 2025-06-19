import 'package:ball/constants/app_constans.dart';

import '../game_enitity.dart';
import 'dart:developer' show log;

extension GameConditionStrings on GameConditions {
  String get name {
    switch (this) {
      case (GameConditions.timeLimit):
        return 'Time Limit';
      case (GameConditions.scoreLimit):
        return 'Score Limit';
      case (GameConditions.none):
        return 'none';
    }
  }
}

extension ToGameTeams on String {
  GameTeams get team {
    switch (this) {
      case ('Home'):
        return GameTeams.home;
      case ('Away'):
        return GameTeams.away;
      default:
        return GameTeams.none;
    }
  }
}

extension DigitHandler on int {
  String get doubleDigits {
    String doubleDigitString = this < 10 ? '0$this' : '$this';
    return doubleDigitString;
  }
}

extension Logger on Object {
  void debugLog({String? message}) {
    log('MESSAGE: $message: $this', name: 'DEBUG_LOG');
  }
}

extension IntegerToMonth on int {
  // Converts integer to month of year
  String intToMonth() => Strings.months.elementAt(this - 1);

  // Converts integer to day of week
  String intToDay() => Strings.days.elementAt(this - 1);
}
