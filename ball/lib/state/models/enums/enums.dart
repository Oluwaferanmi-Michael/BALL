typedef Score = int;
typedef GameId = String;
typedef ScoreLimit = int;
typedef TeamName = String;
typedef GameDuration = int;
typedef GameDate = DateTime;

enum AppScreenState { mainNav, game }

enum SearchWidgetState { icon, search }

enum ButtonType { primary, secondary }

enum GameStatus { ongoing, completed, cancelled, notStarted }

enum GamePositions {
  pointGuard,
  shootingGuard,
  smallForward,
  powerForward,
  center,
  versatile,
  none,
}

enum Role { coach, enthusiasts, player, manager }

enum GameTeams { home, away, none }

enum GameConditions { timeLimit, scoreLimit, none }
