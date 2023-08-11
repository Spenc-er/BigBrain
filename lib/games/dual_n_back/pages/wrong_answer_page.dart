import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:game_template/helpers/colors.dart';
import 'package:game_template/helpers/phone_properties.dart';
import 'package:game_template/games/dual_n_back/controller/sequence_memory_controller.dart';
import 'package:game_template/widgets/button/elevated_button.dart';
import 'package:go_router/go_router.dart';

class WrongAnswer extends StatefulWidget {
  WrongAnswer({Key? key}) : super(key: key);

  @override
  State<WrongAnswer> createState() => _WrongAnswerState();
}

class _WrongAnswerState extends State<WrongAnswer> {
  late DualNBackController controller;
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    context = context;
    _initState();
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(child: _levelText()),
                  SizedBox(height: 20),
                  _retryButton(context),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(Phone.width(context) / 3.5, 20),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        "HOME",
                        style: TextStyle(
                          color: Color.fromRGBO(52, 168, 83, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => {GoRouter.of(context).go('/')}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _initState() {
    controller = Get.find();
  }

  Widget _retryButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => {
        _retry(),
      },
      child: Text(
        "RETRY",
        style: TextStyle(
          color: Color.fromRGBO(52, 168, 83, 1),
          fontWeight: FontWeight.bold,
        ),
      ),
      primary: Colors.white,
      borderRadius: 20,
      borderSideWidth: 1.5,
      borderSideColor: Colors.white,
      size: Size(Phone.width(context) / 3.5, 20),
    );
  }

  _retry() {
    controller.dualNBackValueController.hardReset();
    controller.selectGamePage();
  }

  Widget _levelText() {
    var correct1 = controller.correctValue();
    var wrong = controller.wrongValue();
    var match1 = controller.matchValue();
    double correct = correct1 + .0;
    double match = match1 + .0;
    var score = 0.00;
    var rate = "0.00";
    if (wrong == 0)
      rate = "100.00";
    else if (wrong < match) {
      score = (correct / match) * 100;
      rate = score.toStringAsFixed(2);
    }

    return Text(
      'Success: $rate%',
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xffE4FF78),
        fontSize: 40,
        fontFamily: 'GemunuLibre',
        fontWeight: FontWeight.bold,
      ),
    );
  }

}
