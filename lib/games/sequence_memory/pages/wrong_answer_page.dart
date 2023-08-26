import 'package:flutter/material.dart';
import 'package:game_template/games/sequence_memory/controller/sequence_memory_value_controller.dart';
import 'package:get/get.dart';
import 'package:game_template/helpers/colors.dart';
import 'package:game_template/helpers/phone_properties.dart';
import 'package:game_template/games/sequence_memory/controller/sequence_memory_controller.dart';
import 'package:game_template/widgets/button/elevated_button.dart';
import 'package:game_template/widgets/text/less_futured_text.dart';
import 'package:go_router/go_router.dart';
import 'package:game_template/games/numbers_memory/controllers/share_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrongAnswer extends StatefulWidget {
  WrongAnswer({Key? key}) : super(key: key);

  @override
  State<WrongAnswer> createState() => _WrongAnswerState();
}

class _WrongAnswerState extends State<WrongAnswer> {
  late SequenceMemoryController controller;
  late BuildContext context;
  late SequenceMemoryValueController vC;

  _initState() {
    controller = Get.find();
    vC = controller.sequenceMemoryValueController;
    saveGameUsedTime();
  }

  var ishow = AppSharedPref.isProfileFilled();

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
                  if (!ishow) ...[
                    Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message: "Please fill in profile information.",
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(Phone.width(context) / 2, 40),
                            backgroundColor: Colors.grey,
                          ),
                          child: Text(
                            "SUBMIT RESULT",
                            style: TextStyle(
                              color: Color.fromRGBO(52, 168, 83, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: null),
                    ),
                  ] else ...[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(Phone.width(context) / 2, 40),
                          backgroundColor: ishow ? Colors.white : Colors.grey,
                        ),
                        child: Text(
                          "SUBMIT RESULT",
                          style: TextStyle(
                            color: Color.fromRGBO(52, 168, 83, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => ishow
                            ? {
                                Get.find<SequenceMemoryController>()
                                    .surveyPage()
                              }
                            : null),
                  ],
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

  Future<void> saveGameUsedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('game_lvl', vC.levelCount.toString());
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
    controller.sequenceMemoryValueController.hardReset();
    controller.selectGamePage();
  }

  Widget _levelText() {
    var levelCount =
        controller.sequenceMemoryValueController.levelCount.toString();

    return LessText.lessFuturedText(
      text: 'Level $levelCount',
      fontSize: 70,
      color: Color(0xffE4FF78),
    );
  }
}
