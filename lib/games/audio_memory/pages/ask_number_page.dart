import 'package:flutter/material.dart';
import 'package:game_template/games/audio_memory/controllers/number_memory_value_controller.dart';
import 'package:game_template/games/audio_memory/controllers/numbers_memory_controller.dart';
import 'package:get/get.dart';
import '/helpers/colors.dart';
import '/helpers/phone_properties.dart';

class AskAudioNumber extends StatefulWidget {
  AskAudioNumber({Key? key}) : super(key: key);

  @override
  _AskAudioNumberState createState() => _AskAudioNumberState();
}

class _AskAudioNumberState extends State<AskAudioNumber> {
  var textController = TextEditingController();

  late BuildContext context;
  late AudioMemoryController controller;
  late AudioMemoryValueController valueController;

  bool isKeyboardOpen = false;
  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    controller = Get.find();
    valueController = controller.valueController;
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _quesitonText(),
              SizedBox(height: 15),
              _textField(),
              SizedBox(height: 20),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quesitonText() {
    return Text(
      "What was the number?",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'GemunuLibre',
        color: Colors.white,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  FocusNode textFieldFocusNode = FocusNode();

  Widget _textField() {
    return Container(
      width: Phone.width(context) / 1.3,
      child: TextField(
        autofocus: true,
        focusNode: textFieldFocusNode,
        controller: textController,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: MyColors.numbersMemorySemiDarkBlue,
        ),
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(Phone.width(context) / 3, 40),
        backgroundColor: Colors.white,
      ),
      onPressed: () => submit(),
      child: Text(
        'SUBMIT',
        style: TextStyle(
          color: Color.fromRGBO(52, 168, 83, 1),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  submit() {
    valueController.usersAnswer = textController.text;
    valueController.checkAnswer(controller);
    textController.clear();
  }
}
