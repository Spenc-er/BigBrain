import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/helpers/colors.dart';
import '/helpers/phone_properties.dart';
import '/games/numbers_memory/controllers/numbers_memory_controller.dart';
import '/games/numbers_memory/controllers/number_memory_value_controller.dart';

class AskNumber extends StatefulWidget {
  AskNumber({Key? key}) : super(key: key);

  @override
  _AskNumberState createState() => _AskNumberState();
}

class _AskNumberState extends State<AskNumber> {
  var textController = TextEditingController();

  late BuildContext context;
  late NumbersMemoryController controller;
  late NumbersMemoryValueController valueController;

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
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(52, 168, 83, 1),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  submit() {
    valueController.usersAnswer = textController.text;
    valueController.checkAnswer(controller);
    textController.clear();
  }
}
