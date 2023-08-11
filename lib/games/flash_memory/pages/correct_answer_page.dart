import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:game_template/helpers/colors.dart';
import 'package:game_template/helpers/phone_properties.dart';
import 'package:game_template/games/flash_memory/controller/sequence_memory_controller.dart';
import 'package:game_template/widgets/button/elevated_button.dart';
import 'package:game_template/widgets/text/less_futured_text.dart';
import 'package:go_router/go_router.dart';
import 'package:game_template/games/flash_memory/values/const_values.dart';

class CorrectAnswer extends StatefulWidget {
  CorrectAnswer({Key? key}) : super(key: key);

  @override
  State<CorrectAnswer> createState() => CorrectAnswerState();
}

class CorrectAnswerState extends State<CorrectAnswer> {
  late FlashMemoryController controller;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    context = context;
    _initState();
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Flexible(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(child: _levelText()),
                    Flexible(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: GridView.count(
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          crossAxisCount: 3,
                          children: widgetList,
                        ),
                      ),
                    ),
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
      ),
    );
  }

  late List<Widget> widgetList = [];
  _initState() {
    controller = Get.find();
    widgetList = List.generate(9, (index) => _buildCard(index));
  }

  Widget _buildCard(int index) {
    return Obx(
      () => InkWell(
        onTap: () => null,
        child: AnimatedContainer(
          duration: Consts.cardAnimationDuration,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: controller.cardColors[index].value,
          ),
        ),
      ),
    );
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
    controller.resetCard();
    controller.flashMemoryValueController.hardReset();
    controller.selectGamePage();
  }

  Widget _levelText() {
    return LessText.lessFuturedText(
      text: 'WELL DONE',
      fontSize: 40,
      color: Color(0xffE4FF78),
    );
  }
}
