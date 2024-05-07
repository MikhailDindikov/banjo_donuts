

import 'package:just_audio/just_audio.dart';

class Zvuki {
  static bool musPlDon = false;
  static AudioPlayer muslo = AudioPlayer();

  static (bool, List)? goDonMu(String name) {
    Zvuki.musPlDon = true;
    muslo
      ..setLoopMode(LoopMode.one)
      ..setAsset('assets/$name')
      ..play();

    return (true, []);
  }

  static (bool, List)? musDonOne(String name) {
    AudioPlayer()
      ..setAsset('assets/$name')
      ..play();

    return (true, []);
  }

  static (int, List)? stoDonMu() {
    Zvuki.musPlDon = false;
    muslo.stop();
    return (321265, []);
  }
}
