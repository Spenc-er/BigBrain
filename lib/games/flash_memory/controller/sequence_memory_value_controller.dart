import 'package:game_template/helpers/colors.dart';
import 'package:get/get.dart';
import 'package:game_template/games/flash_memory/controller/helpers/card_selector.dart';
import 'package:game_template/games/flash_memory/controller/helpers/sequencer.dart';
import 'package:game_template/games/flash_memory/controller/sequence_memory_controller.dart';

class FlashMemoryValueController extends GetxController {
  FlashMemoryValueController() {
    c = Get.find();
  }

  int _levelCounter = 1;
  int get levelCount => _levelCounter;
  int _userClickCounter = 0;

  List<int> queue = [];
  List<int> userClickRow = [];
  Map<int, int> valueCounts = {};
  List<int> keysWithOddValues = [];
  late FlashMemoryController c;

  incrementLevel() => _levelCounter++;

  reset() {
    userClickRow.clear();
    _userClickCounter = 0;
  }

  hardReset() {
    queue.clear();
    valueCounts.clear();
    keysWithOddValues.clear();
    _levelCounter = 1;
    c.clickable.value = false;
    reset();
  }

  play() {
    Sequencer.sequence();
    CardSelector.select();
    firstStep();
    getAnswer(queue);
    queue.clear();
  }

  getAnswer(List<int> queue) {
    for (var value in queue) {
      if (valueCounts.containsKey(value)) {
        valueCounts[value] = valueCounts[value]! + 1;
      } else {
        valueCounts[value] = 1;
      }
    }
  }

  userStepCheck(int index) {
    if (queue[_userClickCounter] == index) {
      _correctStep();
    } else {
      _wrongAnswer();
    }
  }

  wrongAns() {
    _wrongAnswer();
  }

  selectTile(int index) {
    if (c.cardColors[index].value == MyColors.transparentBlackForCard)
      c.selectWhiteCard(index);
    else
      c.selectTransparentCard(index);
  }

  firstStep() async {
    await Future.delayed(Duration(milliseconds: 5500), () => correctStep());
  }

  correctStep() async {
    await _correctStep();
  }

  _correctStep() async {
    _userClickCounter++;
    if (_userClickCounter < 5) {
      _levelDoneSignal();
      // reset();
      incrementLevel();
      await Future.delayed(Duration(milliseconds: 100), () => play());
    } else {
      keysWithOddValues =
          valueCounts.keys.where((key) => valueCounts[key]! % 2 != 0).toList();
      keysWithOddValues.sort();
      print(keysWithOddValues);
      c.clickable.value = true;
      return;
      // _wrongAnswer();
    }
  }

  _levelDoneSignal() async {
    await Future.delayed(
        Duration(milliseconds: 110), () => c.selectCorrectAnswerBackground());
    await Future.delayed(
        Duration(milliseconds: 200), () => c.resetBackground());
  }


  _wrongAnswer() async {
    print(keysWithOddValues);
    List<int> selectExtra = [];
    List<int> unselectCorrect = [];

    for (int num in c.getAnswer()) {
      if (!keysWithOddValues.contains(num)) {
        selectExtra.add(num);
      }
    }

    for (int num in keysWithOddValues) {
      if (!c.getAnswer().contains(num)) {
        unselectCorrect.add(num);
      }
    }
    for (var i in selectExtra) {
      c.selectExtraAnswer(i);
    }
    for (var i in unselectCorrect) {
      c.unselectCorrectAnswer(i);
    }
    if (selectExtra.length < 1 && unselectCorrect.length < 1) {
      await Future.delayed(Duration(milliseconds: 110), () => c.levelDone());
      await Future.delayed(
          Duration(milliseconds: 200), () => c.resetBackground());
      c.selectCorrectAnswerPage();
    } else
      c.selectWrongAnswerPage();
  }
}
