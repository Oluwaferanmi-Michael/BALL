// import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'game_constants.dart';

class Game {
  final GameId id = Uuid().v1();
  late final Score homeTeamScore;
  final Score awayTeamScore;
  final ScoreLimit? scoreLimit;
  final TeamName awayTeamName;
  final TeamName homeTeamName;
  final TeamName? winner;
  final GameTeams? winningTeam;
  final GameDuration? time;
  String gameDate = DateTime.now().toIso8601String();

  Game({
    required this.homeTeamScore,
    required this.awayTeamScore,
    required this.scoreLimit,
    required this.awayTeamName,
    required this.homeTeamName,
    this.winningTeam,
    this.winner,
    this.time,
  });

  Game.none()
      : homeTeamName = '',
        awayTeamName = '',
        homeTeamScore = 0,
        awayTeamScore = 0,
        winner = null,
        winningTeam = GameTeams.none,
        scoreLimit = 0,
        time = null;

  Game.fromDatabase({required Map<String, dynamic> data})
      : homeTeamScore = data[GameConstants.homeTeamScore],
        awayTeamScore = data[GameConstants.awayTeamScore],
        awayTeamName = data[GameConstants.awayTeamName],
        homeTeamName = data[GameConstants.homeTeamName],
        winner = data[GameConstants.winner],
        winningTeam = (data[GameConstants.winningTeam] as String).team,
        time = data[GameConstants.time],
        gameDate = data[GameConstants.gameDate],
        scoreLimit = data[GameConstants.scoreLimit];

  //
  Map<String, dynamic> toDatabase() {
    TeamName _getWinner() {
      if (awayTeamScore > homeTeamScore) {
        return awayTeamName;
      } else if (awayTeamScore < homeTeamScore) {
        return homeTeamName;
      } else {
        return 'none';
      }
    }

    ;
    GameTeams _getWinningTeam() {
      if (awayTeamScore > homeTeamScore) {
        return GameTeams.away;
      } else if (awayTeamScore < homeTeamScore) {
        return GameTeams.home;
      } else {
        return GameTeams.none;
      }
    }

    ;

    return {
      GameConstants.id: id,
      GameConstants.homeTeamName: homeTeamName,
      GameConstants.awayTeamName: awayTeamName,
      GameConstants.homeTeamScore: homeTeamScore,
      GameConstants.awayTeamScore: awayTeamScore,
      GameConstants.winner: _getWinner(),
      GameConstants.winningTeam: _getWinningTeam().name,
      GameConstants.scoreLimit: time == null ? scoreLimit : 0,
      GameConstants.time: scoreLimit == null ? time : 0,
      GameConstants.gameDate: gameDate,
    };
  }

  Game copyWith({
    TeamName? homeTeamName,
    TeamName? awayTeamName,
    GameTeams? winningTeam,
    Score? homeTeamScore,
    Score? awayTeamScore,
  }) =>
      Game(
          time: this.time,
          scoreLimit: this.scoreLimit,
          homeTeamName: homeTeamName ?? this.homeTeamName,
          awayTeamName: awayTeamName ?? this.awayTeamName,
          homeTeamScore: homeTeamScore ?? this.homeTeamScore,
          awayTeamScore: awayTeamScore ?? this.awayTeamScore,
          winningTeam: winningTeam,
          winner: this.winner);

  @override
  bool operator ==(covariant Game other) {
    return identical(other, this) || 
    (
      id == other.id &&
      winner == other.winner &&
      time == other.time &&
      homeTeamName == other.homeTeamName &&
      awayTeamName == other.awayTeamName &&
      awayTeamScore == other.awayTeamScore &&
      homeTeamScore == other.homeTeamScore &&
      scoreLimit == other.scoreLimit &&
      winningTeam == other.winningTeam
    );
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        winner,
        time,
        homeTeamName,
        awayTeamName,
        homeTeamScore,
        awayTeamScore,
        scoreLimit,
        winningTeam,
      ]);
}

typedef Score = int;
typedef GameId = String;
typedef ScoreLimit = int;
typedef TeamName = String;
typedef GameDuration = int;
typedef GameDate = DateTime;

enum GameTeams { home, away, none }

enum GameConditions { timeLimit, scoreLimit, none }

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

extension ToGameCondition on String {
  GameConditions toGameCondition(String value) {
    switch (value) {
      case ('Time Limit'):
        return GameConditions.timeLimit;
      case ('Score Limit'):
        return GameConditions.scoreLimit;
      default:
        return GameConditions.none;
    }
  }
}


// required bool draw,
//     required Score homeTeamScore,
//     required Score awayTeamScore,
//     ScoreLimit? scoreLimit,
//     required TeamName awayTeamName,
//     required TeamName homeTeamName,
//     GameDuration? time,