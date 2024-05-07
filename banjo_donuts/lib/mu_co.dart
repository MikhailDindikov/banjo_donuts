import 'package:banjo_donuts/hern/pomo.dart';
import 'package:banjo_donuts/hern/zvuki.dart';
import 'package:get/get.dart';

class MuCo extends FullLifeCycleController with FullLifeCycleMixin {
  @override
  void onDetached() {}

  @override
  void onInactive() {
    if (Zvuki.musPlDon) {
      Zvuki.stoDonMu();
    }
  }

  @override
  void onPaused() {}

  @override
  void onResumed() {
    if ((Pomo.pomo!.getBool('donms') ?? true)) {
      Zvuki.goDonMu('ms.mp3');
    }
  }

  @override
  void onHidden() {}
}
