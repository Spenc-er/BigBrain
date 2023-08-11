import 'package:get/get.dart';
import 'package:game_template/games/flash_memory/controller/sequence_memory_value_controller.dart';
import 'dart:math';

class Sequencer {
  Sequencer() {
    c = Get.find();
  }

  late FlashMemoryValueController c;

  static sequence() => Sequencer()._chooseCard();

  _chooseCard() {
    var numbersToAdd = List.generate(10, (index) => index);
    var random = Random();

    while (c.queue.length < 5 && numbersToAdd.isNotEmpty) {
      var index = random.nextInt(numbersToAdd.length - 1);
      var number = numbersToAdd[index];

      if (!_isNumberCopy(number)) {
        c.queue.add(number);
      }
      numbersToAdd.removeAt(index);
    }
  }

  bool _isNumberCopy(int number) {
    return c.queue.contains(number);
  }
}
