import 'package:flutter/material.dart';
import 'package:game_template/games/sequence_memory/pages/survey.dart';
import 'package:get/get.dart';
import 'package:game_template/helpers/colors.dart';
import 'package:game_template/games/sequence_memory/controller/sequence_memory_value_controller.dart';
import 'package:game_template/games/sequence_memory/pages/game_page.dart';
import 'package:game_template/games/sequence_memory/pages/info_page.dart';
import 'package:game_template/games/sequence_memory/pages/wrong_answer_page.dart';

class SequenceMemoryController extends GetxController {
  SequenceMemoryValueController get sequenceMemoryValueController =>
      Get.find<SequenceMemoryValueController>();

  var page = 0.obs;
  var clickable = true;
  var backGroundColor = MyColors.myBlue.obs;

  List<Rx<Color>> cardColors = [
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
    MyColors.transparentBlackForCard.obs,
  ];

  List<Widget> pages = [
    InfoPage(),
    GamePage(),
    WrongAnswer(),
    Survey()
  ];

  selectInfoPage() => page.value = 0;
  selectGamePage() => page.value = 1;
  selectWrongAnswerPage() => page.value = 2;
  void surveyPage() => page.value = 3;
  selectCorrectAnswerBackground() =>
      backGroundColor.value = MyColors.myLightBlue;
  resetBackground() => backGroundColor.value = MyColors.myBlue;

  selectWhiteCard(int index) => cardColors[index].value = Colors.white;
  selectTransparentCard(int index) =>
      cardColors[index].value = MyColors.transparentBlackForCard;
}
