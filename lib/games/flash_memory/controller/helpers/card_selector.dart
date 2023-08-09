import 'package:get/get.dart';
import 'package:game_template/games/flash_memory/values/const_values.dart';
import '../sequence_memory_controller.dart';
import '../sequence_memory_value_controller.dart';

class CardSelector {
  static select() => CardSelector()._select();

  CardSelector() {
    vC = Get.find();
    c = Get.find();
  }

  late FlashMemoryValueController vC;
  late FlashMemoryController c;

  _select() async {
    for (var i = 0; i <= vC.queue.length - 1; i++) {
      var colorToBeChangeIndex = vC.queue[i];
      _changeCard(colorToBeChangeIndex);
    }
  }

  _changeCard(int index) async {
    await Future.delayed(
      Consts.showDuration,
      () => c.selectWhiteCard(index),
    );
    await Future.delayed(
      Consts.cardDisplayDuration,
      () => c.selectTransparentCard(index),
    );
  }
}
