import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final _player = AudioPlayer();

  static Future<void> playMilestone() async {
    // Make sure "assets/milestone.mp3" is included in your pubspec.yaml under assets.
    await _player.play(AssetSource('milestone.mp3'));
  }
}
