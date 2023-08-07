import 'package:flutter/material.dart';
import 'package:game_template/games/audio_memory/audio_memory_page.dart';
import 'package:game_template/games/audio_memory/controllers/number_memory_value_controller.dart';
import 'package:game_template/games/audio_memory/controllers/numbers_memory_controller.dart';
import 'package:game_template/games/numbers_memory/controllers/share_pref.dart';
import 'package:game_template/games/numbers_memory/controllers/store_controller.dart';
import 'package:game_template/src/games_services/score.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../src/player_progress/player_progress.dart';
import '../../audio_memory_page.dart';
import '/helpers/colors.dart';
import '/helpers/phone_properties.dart';
import '/widgets/text/less_futured_text.dart';

import 'helpers/wrong_numbers_detecetor.dart';

class WrongAnswerAudio extends StatefulWidget {
  WrongAnswerAudio({Key? key}) : super(key: key);

  @override
  State<WrongAnswerAudio> createState() => _WrongAnswerAudioState();
}

class _WrongAnswerAudioState extends State<WrongAnswerAudio> {
  late AudioMemoryController c;
  late AudioMemoryValueController vC;
  var store = Get.find<StoreController>();
  late BuildContext context;
  late StoreController controller;

  _initState() {
    c = Get.find();
    controller = Get.find<StoreController>();
    vC = c.valueController;
    saveGameUsedTime();
  }

  void dispose() {
    Get.delete<AudioMemory>();
    super.dispose();
  }

  Future<void> saveGameUsedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Score saveStore = new Score(1, 10,
        DateTime.now().difference(DateTime.parse(store.startTime.value)));
    prefs.setString('game_lvl', vC.levelCounter.toString());
    prefs.setString('game_time', saveStore.formattedTime);
    final playerProgress = context.read<PlayerProgress>();
    var lvl = vC.levelCounter > 11 ? 2 : (vC.levelCounter > 6 ? 1 : 0);
    playerProgress.setLevelReached(lvl);
  }

  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    var ishow = AppSharedPref.isProfileFilled();

    Score score = new Score(1, 10,
        DateTime.now().difference(DateTime.parse(store.startTime.value)));
    _initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.myBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _numberText(),
                    SizedBox(height: 10),
                    _showNumberText(vC.number),
                    SizedBox(height: 20),
                    _yourAnswerText(),
                    SizedBox(height: 10),
                    _showYourAnswerText(vC.number, vC.usersAnswer),
                    SizedBox(height: 30),
                    _showLevelText(vC.levelCounter),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Score: ${score.score}\n'
                        'Time: ${score.formattedTime}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffE4FF78),
                          fontSize: 40,
                          fontFamily: 'GemunuLibre',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    retryButton(),
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
                            child: Text("Submit Result"),
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
                              ? {Get.find<AudioMemoryController>().surveyPage()}
                              : null),
                    ],
                    SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(Phone.width(context) / 2, 40),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton() => Container(
        width: Phone.width(context),
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () => {GoRouter.of(context).go('/')},
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      );

  Text _numberText() => LessText.lessFuturedText(
        text: 'Number',
        color: Colors.white,
      );

  Text _showNumberText(String number) => LessText.lessFuturedText(
        text: number,
        color: Colors.white,
        fontFamily: null,
        fontSize: 25,
      );

  Text _yourAnswerText() => LessText.lessFuturedText(
        text: 'Your Answer',
        color: Colors.white,
      );

  Row _showYourAnswerText(String answer, String userAnswer) => WrongDetecetor(
        answer: answer,
        userAnswer: userAnswer,
      ).detect();

  Text _showLevelText(int level) => LessText.lessFuturedText(
        text: 'Level $level',
        color: Color(0xffE4FF78),
        fontSize: 50,
      );

  Widget retryButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(Phone.width(context) / 4, 40),
          backgroundColor: Colors.white,
        ),
        onPressed: () {
          controller.updateTime(
              DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()));
          c.valueController.reset(c.valueController.resetLevel);
          c.selectShowNumberPage();
        },
        child: Text(
          'RETRY',
          style: TextStyle(
            color: Color.fromRGBO(52, 168, 83, 1),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
}
