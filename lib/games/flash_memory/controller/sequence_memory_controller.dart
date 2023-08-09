import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:game_template/helpers/colors.dart';
import 'package:game_template/games/flash_memory/controller/sequence_memory_value_controller.dart';
import 'package:game_template/games/flash_memory/pages/game_page.dart';
import 'package:game_template/games/flash_memory/pages/info_page.dart';
import 'package:game_template/games/flash_memory/pages/wrong_answer_page.dart';

class FlashMemoryController extends GetxController {
  FlashMemoryValueController get flashMemoryValueController =>
      Get.find<FlashMemoryValueController>();

  var page = 0.obs;
  var clickable = false.obs;
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
  ];
  showButton() => clickable.value;

  selectInfoPage() => page.value = 0;
  selectGamePage() => page.value = 1;
  selectWrongAnswerPage() => page.value = 2;
  List<int> getAnswer() {
    List<int> blueIndices = [];
    for (int index = 0; index < cardColors.length; index++) {
      if (cardColors[index].value == MyColors.myBlue) {
        blueIndices.add(index);
      }
    }
    return blueIndices;
  }

  selectCorrectAnswerBackground() => backGroundColor.value = MyColors.myBlue1;
  resetBackground() => backGroundColor.value = MyColors.myBlue;

  selectWhiteCard(int index) => cardColors[index].value = Colors.white;
  selectTransparentCard(int index) =>
      cardColors[index].value = MyColors.transparentBlackForCard;
}
