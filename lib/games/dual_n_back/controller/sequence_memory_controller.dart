
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:game_template/helpers/colors.dart';
import 'package:game_template/games/dual_n_back/controller/sequence_memory_value_controller.dart';
import 'package:game_template/games/dual_n_back/pages/game_page.dart';
import 'package:game_template/games/dual_n_back/pages/info_page.dart';
import 'package:game_template/games/dual_n_back/pages/wrong_answer_page.dart';

class DualNBackController extends GetxController {
  DualNBackValueController get dualNBackValueController =>
      Get.find<DualNBackValueController>();

  var page = 0.obs;
  var clickable = false.obs;
  var soundClickable = false.obs;
  var backGroundColor = MyColors.myBlue.obs;
  var correct = 0.obs;
  var wrong = 0.obs;
  var matched = 0.obs;
  var level = 2.obs;
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
  correctValue() => correct.value;
  matchValue() => matched.value;
  wrongValue() => wrong.value;
  selectInfoPage() => page.value = 0;
  selectGamePage() => page.value = 1;
  selectWrongAnswerPage() => page.value = 2;

  selectCorrectAnswerBackground() =>
      backGroundColor.value = MyColors.myLightBlue;
  resetBackground() => backGroundColor.value = MyColors.myBlue;

  selectWhiteCard(int index) => cardColors[index].value = Colors.white;
  selectTransparentCard(int index) =>
      cardColors[index].value = MyColors.transparentBlackForCard;
}
