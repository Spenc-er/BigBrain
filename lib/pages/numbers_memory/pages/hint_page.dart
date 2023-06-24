import 'package:flutter/material.dart';
import 'package:game_template/pages/numbers_memory/controllers/store_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/helpers/colors.dart';
import '/helpers/phone_properties.dart';
import '/pages/numbers_memory/controllers/numbers_memory_controller.dart';

class HintPage extends StatefulWidget {
  HintPage({Key? key}) : super(key: key);

  @override
  State<HintPage> createState() => _HintPageState();
}

class _HintPageState extends State<HintPage> {
  late BuildContext context;
  late StoreController controller;

  void initState() {
    controller = Get.put(StoreController());
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: SafeArea(
        child: Container(
          width: Phone.width(context),
          height: Phone.heigth(context),
          child: Column(
            children: [
              backButton(),
              Expanded(
                child: hint(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget hint() {
    return Container(
      width: Phone.width(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Numbers Memory",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'GemunuLibre',
              color: Colors.white,
              fontSize: 35,
            ),
          ),
          SizedBox(height: 17),
          Text(
            "The humans are remember average 7 numbers.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'GemunuLibre',
              color: Colors.white,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          startButton(),
        ],
      ),
    );
  }

  Widget startButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(Phone.width(context) / 2, 40),
          backgroundColor: Color.fromRGBO(244, 180, 0, 1),
        ),
        child: Text("Start"),
        onPressed: () => {
              controller.updateTime(
                  DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now())),
              Get.find<NumbersMemoryController>().selectShowNumberPage()
            });
  }

  Widget backButton() {
    return Container(
      alignment: Alignment.bottomLeft,
      width: Phone.width(context),
      child: IconButton(
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}
