import 'package:get/get.dart';
import 'package:game_template/games/sequence_memory/controller/helpers/card_selector.dart';
import 'package:game_template/games/sequence_memory/controller/helpers/sequencer.dart';
import 'package:game_template/games/sequence_memory/controller/sequence_memory_controller.dart';

class SequenceMemoryValueController extends GetxController {
  SequenceMemoryValueController() {
    c = Get.find();
  }

  int _levelCounter = 1;
  int get levelCount => _levelCounter;
  int _userClickCounter = 0;

  List<int> queue = [];
  List<int> userClickRow = [];

  late SequenceMemoryController c;

  incrementLevel() => _levelCounter++;

  reset() {
    userClickRow.clear();
    _userClickCounter = 0;
  }

  hardReset() {
    queue.clear();
    _levelCounter = 1;
    reset();
  }

  play() {
    Sequencer.sequence();
    CardSelector.select();
  }

  userStepCheck(int index) {
    if (queue[_userClickCounter] == index) {
      _correctStep();
    } else {
      _wrongAnswer();
    }
  }

  selecTile(int index) {
    _SelectTile(index);
  }

  _correctStep() async {
    _userClickCounter++;
    if (_userClickCounter == levelCount) {
      _levelDoneSignal();
      reset();
      incrementLevel();
      await Future.delayed(Duration(milliseconds: 200), () => play());
    }
  }

  _levelDoneSignal() async {
    await Future.delayed(
        Duration(milliseconds: 110), () => c.selectCorrectAnswerBackground());
    await Future.delayed(
        Duration(milliseconds: 200), () => c.resetBackground());
  }

  _SelectTile(int index) async {
    c.selectWhiteCard(index);
    await Future.delayed(
        Duration(milliseconds: 200), () => c.selectTransparentCard(index));
  }

  _wrongAnswer() {
    reset();
    c.selectWrongAnswerPage();
  }
}
