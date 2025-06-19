import 'package:ball/components/last_game_component.dart';
// import 'package:ball/components/score_value_component.dart';
// import 'package:ball/state/models/game_enitity.dart';
// import 'package:ball/state/models/utils/ext.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class GameSummaryComponent extends LastGameDataWidget {
  const GameSummaryComponent({super.key, required super.game})
    : super(label: '');

  @override
  Widget build(BuildContext context) =>
      LastGameDataWidget(game: game).copyWith(label: '');
}

// class GameSummaryWidget extends StatelessWidget {
//   const GameSummaryWidget({super.key, required this.game});

//   final Game game;

//   @override
//   Widget build(BuildContext context) {
//     return
//     Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: const BoxDecoration(),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             '${game.gameDate.weekday.intToDay()}, ${game.gameDate.month.intToMonth()} ${game.gameDate.day}',
//             style: GoogleFonts.poppins(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               color: const Color(0xFF0D0018),
//               // const Color.fromARGB(255, 43, 35, 44),
//             ),
//           ),
//           Row(
//             // spacing: 42,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ScoreValueComponent(
//                 team: game.homeTeamName,
//                 gameTeams: GameTeams.home,
//               ),

//               Expanded(
//                 flex: 2,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '${game.homeTeamScore} \t\t - \t\t ${game.awayTeamScore}',
//                       style: GoogleFonts.bebasNeue(
//                         fontSize: 36,
//                         fontWeight: FontWeight.w600,
//                         color: const Color.fromARGB(255, 43, 35, 44),
//                       ),
//                     ),
//                     Text(
//                       game.scoreLimit != 0
//                           ? '${game.scoreLimit} pts'
//                           : '${game.duration}:00 min',
//                       style: const TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                         color: Color.fromARGB(255, 43, 35, 44),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               ScoreValueComponent(
//                 team: game.awayTeamName,
//                 gameTeams: GameTeams.away,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
