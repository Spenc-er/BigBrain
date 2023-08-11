import 'package:get/get.dart';
import 'package:game_template/helpers/random_number_generator.dart';
import 'package:game_template/games/dual_n_back/controller/sequence_memory_value_controller.dart';

class Sequencer {
  Sequencer() {
    c = Get.find();
  }

  late DualNBackValueController c;

  static sequence() => Sequencer()._chooseCard();

  _chooseCard() {
    while (c.queue.length < 15) {
      var rndNumber = RandomNumber.minMax(0, 9).randomNumber;
      c.queue.add(rndNumber);
    }
  }

  static int? previousNumber;
}
