
class Scores {
  const Scores({
    required this.homeScore,
    required this.awayScore,
  });

  final int homeScore;
  final int awayScore;

  Scores.empty() : homeScore = 0, awayScore = 0;
}