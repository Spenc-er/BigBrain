import 'dart:math';
import 'package:game_template/games/audio_memory/controllers/numbers_memory_controller.dart';
import 'package:get/get.dart';


class AudioMemoryValueController extends AudioMemoryController {
  var levelCounter;
  String number = "";

  String usersAnswer = "";
  var resetLevel;

  int get levelSecond => levelCounter < 8
      ? (sqrt(levelCounter * 2) * 1000).toInt()
      : levelCounter < 11
          ? (sqrt(levelCounter * 5) * 1000).toInt()
          : levelCounter < 14
              ? (sqrt(levelCounter * 8) * 1000).toInt()
              : (sqrt(levelCounter * 11) * 1000).toInt();

  incrementLevel() => levelCounter++;

  AudioMemoryValueController(int initialLevelCounter) {
    levelCounter = initialLevelCounter;
    resetLevel = initialLevelCounter;
  }
  String numberGenerator() {
    number = "";
    var random = Random();
    for (var i = 1; i <= levelCounter; i++) {
      number += random.nextInt(10).toString();
    }
    print('Number: $number');
    return number;
  }

  checkAnswer(AudioMemoryController c) {
    if (usersAnswer.length >= 1) {
      var c = Get.find<AudioMemoryController>();
      if (usersAnswer == number) {
        c.selectCorrectAnswerPage();
      } else {
        c.selectWrongAnswerPage();
      }
    }
  }

  reset(lvl) {
    number = "";
    usersAnswer = "";
    levelCounter = lvl;
  }
}
