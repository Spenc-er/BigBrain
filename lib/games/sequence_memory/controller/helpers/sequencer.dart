import 'package:get/get.dart';
import 'package:game_template/helpers/random_number_generator.dart';
import 'package:game_template/games/sequence_memory/controller/sequence_memory_value_controller.dart';

class Sequencer {
  Sequencer() {
    c = Get.find();
  }

  late SequenceMemoryValueController c;

  static sequence() => Sequencer()._chooseCard();

  _chooseCard() {
    var rndNumber = RandomNumber.minMax(0, 9).randomNumber;
    if (!_isNumberCopy(rndNumber)) {
      c.queue.add(rndNumber);
    }else{
      _chooseCard();
    }
  }

  static int? previousNumber;

  bool _isNumberCopy(int number) {
    if (previousNumber != null) {
      if (previousNumber == number) {
        return true;
      }
    }
    previousNumber = number;
    return false;
  }
}
