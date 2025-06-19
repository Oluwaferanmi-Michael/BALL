import 'package:ball/state/data/audio_play_function.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_sound_notifier.g.dart';

@riverpod
class GameSoundNotifier extends _$GameSoundNotifier {
  @override
  void build() {
    // ref.onDispose(onDispose);

    return;
  }

  final AudioPlayFunctions _audioPlayFunction = AudioPlayFunctions();


  void buzzer() => _audioPlayFunction.playBuzzer();
  void whistle() => _audioPlayFunction.playWhistle();


  void onDispose() {
    _audioPlayFunction.dispose();

  }
}
