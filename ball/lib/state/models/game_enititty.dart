import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

@immutable
class Game {
  final GameId id = Uuid().v1();
  late final Score? homeTeamScore;
  final Score? awayTeamScore;
  final ScoreLimit? scoreLimit;
  final TeamName? awayTeamName;
  final TeamName? homeTeamName;
  final TeamName? winner;
  final GameDuration? time;

  Game(
      {this.homeTeamScore,
      this.awayTeamScore,
      this.scoreLimit,
      this.awayTeamName,
      this.homeTeamName,
      this.winner,
      this.time});

  Game.none()
      : homeTeamName = '',
        awayTeamName = '',
        homeTeamScore = 0,
        awayTeamScore = 0,
        winner = null,
        scoreLimit = null,
        time = null;

  Game.fromDatabase({required Map<String, dynamic> data})
      : homeTeamScore = data[GameConstants.homeTeamScore],
        awayTeamScore = data[GameConstants.awayTeamScore],
        awayTeamName = data[GameConstants.awayTeamName],
        homeTeamName = data[GameConstants.homeTeamName],
        winner = data[GameConstants.winner],
        time = data[GameConstants.time],
        scoreLimit = data[GameConstants.scoreLimit];

  Map<String, dynamic> toDatabase({
    required bool draw,
    required Score homeTeamScore,
    required Score awayTeamScore,
    ScoreLimit? scoreLimit,
    required TeamName awayTeamName,
    required TeamName homeTeamName,
    required TeamName winner,
    GameDuration? time,
  }) {
    return {
      GameConstants.homeTeamName: homeTeamName,
      GameConstants.awayTeamName: awayTeamName,
      GameConstants.homeTeamScore: homeTeamScore,
      GameConstants.awayTeamScore: awayTeamScore,
      GameConstants.draw: draw,
      GameConstants.winner: winner,
      GameConstants.scoreLimit: scoreLimit,
      GameConstants.time: time,
    };
  }

  Game copyWith({
    TeamName? homeTeamName,
    TeamName? awayTeamName,
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
      );
}

class GameConstants {
  static const id = 'id';
  static const gameData = 'gameData';
  static const draw = 'draw';
  static const time = 'time';
  static const homeTeamScore = 'homeTeamScore';
  static const awayTeamScore = 'awayTeamScore';
  static const scoreLimit = 'scoreLimit';
  static const homeTeamName = 'homeTeamName';
  static const winner = 'winner';
  static const awayTeamName = 'awayTeamName';
}

typedef Score = int;
typedef GameId = String;
typedef ScoreLimit = int;
typedef TeamName = String;
typedef GameDuration = int;

enum GameTeams { home, away, none }
