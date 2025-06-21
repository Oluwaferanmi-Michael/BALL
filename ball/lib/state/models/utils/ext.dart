import 'package:ball/constants/app_constans.dart';
import 'package:ball/state/models/enums/enums.dart';

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

extension PositionToString on GamePositions {
  String positionToAbbr() => switch (this) {
    GamePositions.center => 'C',
    GamePositions.pointGuard => 'PG',
    GamePositions.shootingGuard => 'SG',
    GamePositions.smallForward => 'SF',
    GamePositions.powerForward => 'PF',
    (_) => 'V',
  };

  String positionToString() => switch (this) {
    GamePositions.center => 'Center',
    GamePositions.pointGuard => 'Point Guard',
    GamePositions.shootingGuard => 'Shooting Guard',
    GamePositions.smallForward => 'Small Forward',
    GamePositions.powerForward => 'Power Forward',
    (_) => 'Versatile',
  };
}

extension RoleToString on Role {
  String get positionToAbbr => switch (this) {
    Role.coach => 'Coach',
    Role.enthusiasts => 'Enthusiasts',
    Role.manager => 'Manager',
    Role.player => 'Player',
  };
}

extension StringToPosition on String {
  GamePositions get position {
    switch (this) {
      case ('Center'):
        return GamePositions.center;
      case ('Point Guard'):
        return GamePositions.pointGuard;
      case ('Shooting Guard'):
        return GamePositions.shootingGuard;
      case ('Small Forward'):
        return GamePositions.shootingGuard;
      case ('Power Forward'):
        return GamePositions.shootingGuard;
      case ('Versatile'):
        return GamePositions.versatile;
      default:
        return GamePositions.versatile;
    }
  }

  Role get role {
    switch (this) {
      case ('Coach'):
        return Role.coach;
      case ('Enthusiasts'):
        return Role.enthusiasts;
      case ('Manager'):
        return Role.manager;
      case ('Player'):
        return Role.player;
      default:
        return Role.enthusiasts;
    }
  }
}
