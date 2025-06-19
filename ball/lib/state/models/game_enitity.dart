// import 'package:flutter/material.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:uuid/uuid.dart';

import 'game_constants.dart';

class Game {
  final GameId id = const Uuid().v1();
  late final Score homeTeamScore;
  final Score awayTeamScore;
  final ScoreLimit? scoreLimit;
  final TeamName awayTeamName;
  final TeamName homeTeamName;
  final TeamName? winner;
  final GameTeams? winningTeam;
  final GameDuration? duration;
  DateTime gameDate = DateTime.now().toUtc();
  // .toIso8601String();

  Game({
    required this.homeTeamScore,
    required this.awayTeamScore,
    this.scoreLimit,
    required this.awayTeamName,
    required this.homeTeamName,
    // required
    this.winningTeam,
    this.winner,
    this.duration,
  });

  Game.none()
    : homeTeamName = '',
      awayTeamName = '',
      homeTeamScore = 0,
      awayTeamScore = 0,
      winner = null,
      winningTeam = GameTeams.none,
      scoreLimit = 0,
      duration = null;

  Game.fromDatabase({required Map<String, dynamic> data})
    : homeTeamScore = data[GameConstants.homeTeamScore],
      awayTeamScore = data[GameConstants.awayTeamScore],
      awayTeamName = data[GameConstants.awayTeamName],
      homeTeamName = data[GameConstants.homeTeamName],
      winner = data[GameConstants.winner],
      winningTeam = (data[GameConstants.winningTeam] as String).team,
      duration = data[GameConstants.duration],
      gameDate = DateTime.utc(data[GameConstants.gameDate]),
      scoreLimit = data[GameConstants.scoreLimit];

  //
  Map<String, dynamic> toDatabase() {
    TeamName getWinner() {
      if (awayTeamScore > homeTeamScore) {
        return awayTeamName;
      } else if (awayTeamScore < homeTeamScore) {
        return homeTeamName;
      } else {
        return 'none';
      }
    }

    GameTeams getWinningTeam() {
      if (awayTeamScore > homeTeamScore) {
        return GameTeams.away;
      } else if (awayTeamScore < homeTeamScore) {
        return GameTeams.home;
      } else {
        return GameTeams.none;
      }
    }

    return {
      GameConstants.id: id,
      GameConstants.homeTeamName: homeTeamName,
      GameConstants.awayTeamName: awayTeamName,
      GameConstants.homeTeamScore: homeTeamScore,
      GameConstants.awayTeamScore: awayTeamScore,
      GameConstants.winner: getWinner(),
      GameConstants.winningTeam: getWinningTeam().name,
      GameConstants.scoreLimit: scoreLimit ?? 0,
      GameConstants.duration: duration ?? 0,
      GameConstants.gameDate: gameDate,
    };
  }

  Game copyWith({
    TeamName? homeTeamName,
    TeamName? awayTeamName,
    GameTeams? winningTeam,
    Score? homeTeamScore,
    Score? awayTeamScore,
  }) => Game(
    duration: duration,
    scoreLimit: scoreLimit,
    homeTeamName: homeTeamName ?? this.homeTeamName,
    awayTeamName: awayTeamName ?? this.awayTeamName,
    homeTeamScore: homeTeamScore ?? this.homeTeamScore,
    awayTeamScore: awayTeamScore ?? this.awayTeamScore,
    winningTeam: winningTeam,
    winner: winner,
  );

  @override
  bool operator ==(covariant Game other) {
    return identical(other, this) ||
        (id == other.id &&
            winner == other.winner &&
            duration == other.duration &&
            homeTeamName == other.homeTeamName &&
            awayTeamName == other.awayTeamName &&
            awayTeamScore == other.awayTeamScore &&
            homeTeamScore == other.homeTeamScore &&
            scoreLimit == other.scoreLimit &&
            winningTeam == other.winningTeam);
  }

  @override
  String toString() {
    return 'Game(id: $id, winner: $winner, duration: $duration, homeTeamName: $homeTeamName, awayTeamName: $awayTeamName, homeTeamScore: $homeTeamScore, awayTeamScore: $awayTeamScore, scoreLimit: $scoreLimit, winningTeam: $winningTeam)';
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    winner,
    duration,
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
