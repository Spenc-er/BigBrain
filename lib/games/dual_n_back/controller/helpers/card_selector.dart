import 'package:game_template/games/dual_n_back/controller/helpers/auditory_input.dart';
import 'package:get/get.dart';
import 'package:game_template/games/dual_n_back/values/const_values.dart';
import '../sequence_memory_controller.dart';
import '../sequence_memory_value_controller.dart';

class CardSelector {
  static select() => CardSelector()._select();

  CardSelector() {
    vC = Get.find();
    c = Get.find();
    for (int i = 0; i < 15; i++) {
      AuditoryInput a = AuditoryInput();
      auditoryInput.add(a);
    }
  }

  late DualNBackValueController vC;
  late DualNBackController c;
  late List<AuditoryInput> auditoryInput = [];
  _select() async {
    var letter = [];
    for (var i = 0; i < 15; i++) {
      c.clickable.value = true;
      c.soundClickable.value = true;
      var colorToBeChangeIndex = vC.queue[i];

      // if (i == 0) {
      //   await Future.delayed(
      //     Duration(milliseconds: 650),
      //     () => {
      //       c.selectWhiteCard(colorToBeChangeIndex),
      //       auditoryInput[i].speak()
      //     },
      //   );
      //   await Future.delayed(
      //     Consts.cardGaptime,
      //     () => c.selectTransparentCard(colorToBeChangeIndex),
      //   );
      //   letter.add(auditoryInput[i].letter);
      //   continue;
      // }

      await _changeCard(colorToBeChangeIndex, auditoryInput[i]);
      if (i - 2 >= 0) {
        if (vC.queue[i] == vC.queue[i - 2]) {
          c.matched.value = ++c.matched.value;
          if (c.clickable.value == false)
            c.correct.value = ++c.correct.value;
          else
            c.wrong.value = ++c.wrong.value;
        } else {
          if (c.clickable.value == false) c.wrong.value = ++c.wrong.value;
        }
        if (auditoryInput[i].letter == auditoryInput[i - 2].letter) {
          c.matched.value = ++c.matched.value;
          if (c.soundClickable.value == false)
            c.correct.value = ++c.correct.value;
          else
            c.wrong.value = ++c.wrong.value;
        } else {
          if (c.soundClickable.value == false) c.wrong.value = ++c.wrong.value;
        }
      } else {
        if (c.clickable.value == false) c.wrong.value = ++c.wrong.value;
        if (c.soundClickable.value == false) c.wrong.value = ++c.wrong.value;
      }

      letter.add(auditoryInput[i].letter);
    }
    print('correct:' + c.correct.value.toString());
    print('wrong:' + c.wrong.value.toString());
    print(vC.queue);
    print(letter);
    print(c.matched.value);
  }

  _changeCard(int index, AuditoryInput a) async {
    await Future.delayed(
      Consts.cardDisplayDuration,
      () => {c.selectWhiteCard(index), a.speak()},
    );
    await Future.delayed(
      Consts.cardGaptime,
      () => c.selectTransparentCard(index),
    );
  }
}
