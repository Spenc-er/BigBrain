import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:game_template/helpers/colors.dart';
import 'package:game_template/helpers/phone_properties.dart';
import 'package:game_template/games/flash_memory/controller/sequence_memory_controller.dart';
import 'package:game_template/widgets/text/less_futured_text.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late FlashMemoryController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.find();

    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: Container(
        width: Phone.width(context),
        child: Column(
          children: [
            Flexible(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(bottom: 50, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: _gameNameText(),
                    ),
                    SizedBox(height: 25),
                    _infoText(),
                    SizedBox(height: 25),
                    _startButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _gameNameText() => LessText.lessFuturedText(
        text: 'Flash Memory',
        color: Colors.white,
        fontSize: 50,
      );

  Text _infoText() => Text(
        "Memorize and repeat the sequence order.",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'GemunuLibre',
          color: Colors.white,
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      );

  Widget _backButton() => Container(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      );

  ElevatedButton _startButton() {
    controller.flashMemoryValueController.hardReset();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () => controller.selectGamePage(),
      child: Text(
        "START",
        style: TextStyle(
          color: Color.fromRGBO(52, 168, 83, 1),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
