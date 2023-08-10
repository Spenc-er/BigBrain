import 'package:get/get.dart';
import 'package:game_template/games/dual_n_back/controller/helpers/card_selector.dart';
import 'package:game_template/games/dual_n_back/controller/helpers/sequencer.dart';
import 'package:game_template/games/dual_n_back/controller/sequence_memory_controller.dart';

class DualNBackValueController extends GetxController {
  DualNBackValueController() {
    c = Get.find();
  }

  int _levelCounter = 15;
  int get levelCount => _levelCounter;
  int _userClickCounter = 0;

  List<int> queue = [];
  List<int> userClickRow = [];

  late DualNBackController c;

  incrementLevel() => _levelCounter++;

  reset() {
    userClickRow.clear();
    _userClickCounter = 0;
  }

  hardReset() {
    queue.clear();
    _levelCounter = 15;
    c.correct.value = 0;
    c.wrong.value = 0;
    c.matched.value = 0;
    reset();
  }

  play() async {
    Sequencer.sequence();
    await CardSelector.select();
    userStepCheck();
  }

  userStepCheck() {
    _wrongAnswer();
  }

  selecTile(int index) {
    _SelectTile(index);
  }

  _correctStep() async {
    _userClickCounter++;
    if (_userClickCounter == levelCount) {
      _levelDoneSignal();
      reset();
      // incrementLevel();
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
