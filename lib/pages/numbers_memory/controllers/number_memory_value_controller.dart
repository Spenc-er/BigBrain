import 'dart:math';
import 'package:get/get.dart';
import '/pages/numbers_memory/controllers/numbers_memory_controller.dart';

class NumbersMemoryValueController extends NumbersMemoryController {
  var levelCounter = 1;
  String number = "";

  String usersAnswer = "";

  int get levelSecond => levelCounter < 8
      ? (sqrt(levelCounter * 4) * 1000).toInt()
      : (sqrt(levelCounter * 8) * 1000).toInt();

  incrementLevel() => levelCounter++;

  String numberGenerator() {
    number = "";
    var random = Random();
    for (var i = 1; i <= levelCounter; i++) {
      number += random.nextInt(10).toString();
    }
    print('Number: $number');
    return number;
  }

  checkAnswer(NumbersMemoryController c) {
    if (usersAnswer.length >= 1) {
      var c = Get.find<NumbersMemoryController>();
      if (usersAnswer == number) {
        c.selectCorrectAnswerPage();
      } else {
        c.selectWrongAnswerPage();
      }
    }
  }

  reset() {
    number = "";
    usersAnswer = "";
    levelCounter = 1;
  }
}
