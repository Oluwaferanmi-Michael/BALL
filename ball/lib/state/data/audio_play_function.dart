import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:ball/state/data/ext.dart';
import 'package:ball/state/models/game_constants.dart';




class AudioPlayFunctions {
  final _whistlePlayer = ap.AudioPlayer();
  final _buzzerPlayer = ap.AudioPlayer();

  Future<void> playWhistle() async {
    await _whistlePlayer
        .play(ap.AssetSource(AudioAssets.fastDoubleWhistle.audioAssetPath()));
  }

  Future<void> playBuzzer() async {
    await _buzzerPlayer.play(ap.AssetSource(AudioAssets.buzzer.audioAssetPath()));
  }

  void dispose() {
    _whistlePlayer.dispose();
    _buzzerPlayer.dispose();
  }	
  
}
