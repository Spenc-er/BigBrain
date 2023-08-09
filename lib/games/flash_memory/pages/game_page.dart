import 'package:flutter/material.dart';
import 'package:game_template/helpers/phone_properties.dart';
import 'package:get/get.dart';
import 'package:game_template/games/flash_memory/controller/sequence_memory_controller.dart';
import 'package:game_template/games/flash_memory/values/const_values.dart';
import 'package:game_template/widgets/text/less_futured_text.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    _initializeValues();
    return Obx(
      () => Scaffold(
        backgroundColor: controller.backGroundColor.value,
        body: SafeArea(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            color: controller.backGroundColor.value,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: _levelText(),
                  ),
                ),
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
                if (controller.showButton())
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(Phone.width(context) / 2, 40),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "ANSWER",
                          style: TextStyle(
                            color: Color.fromRGBO(52, 168, 83, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => {controller.selectWrongAnswerPage()}),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _levelText() {
    return LessText.lessFuturedText(
      text: 'Flash slide: ' +
          controller.flashMemoryValueController.levelCount.toString(),
      color: Colors.white,
    );
  }

  late FlashMemoryController controller;
  late List<Widget> widgetList = [];

  _initializeValues() {
    controller = Get.find();
    widgetList = List.generate(9, (index) => _buildCard(index));
    controller.flashMemoryValueController.play();
  }

  Widget _buildCard(int index) {
    return Obx(
      () => InkWell(
        onTap: () => _cardClickController(index),
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

  _cardClickController(int index) {
    if (controller.showButton()) {
      controller.flashMemoryValueController.selectTile(index);
    }
  }
}
