import 'package:flutter/material.dart';
import 'package:game_template/games/audio_memory/controllers/number_memory_value_controller.dart';
import 'package:game_template/games/audio_memory/pages/ask_number_page.dart';
import 'package:game_template/games/audio_memory/pages/results_pages/correct_answer_page.dart';
import 'package:game_template/games/audio_memory/pages/results_pages/wrong_answer_page.dart';
import 'package:game_template/games/audio_memory/pages/show_number_page.dart';
import 'package:game_template/games/audio_memory/pages/survey.dart';
import 'package:get/get.dart';
import '/games/audio_memory/pages/hint_page.dart';

class AudioMemoryController extends GetxController {
  AudioMemoryValueController get valueController =>
      Get.find<AudioMemoryValueController>();

  var page = 0.obs;

  bool protectedFocusLost = false;
  bool onShowNumberPage = false;

  List<Widget> pages = [
    HintPage(),
    ShowAudioNumber(),
    AskAudioNumber(),
    CorrectAnswerAudio(),
    WrongAnswerAudio(),
    Survey()
  ];

  void selectHintPage() => page.value = 0;

  void selectShowNumberPage() => page.value = 1;

  void selectAskNumberPage() => page.value = 2;

  void selectCorrectAnswerPage() => page.value = 3;

  void selectWrongAnswerPage() => page.value = 4;

  void surveyPage() => page.value = 5;

  reset(lvl) {
    page.value = 0;
    valueController.reset(lvl);
    protectedFocusLost = false;
    onShowNumberPage = false;
  }
}
