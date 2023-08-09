import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:game_template/games/flash_memory/controller/sequence_memory_controller.dart';
import 'package:game_template/games/flash_memory/controller/sequence_memory_value_controller.dart';

class FlashMemory extends StatefulWidget {
  FlashMemory({Key? key}) : super(key: key);

  @override
  _FlashMemoryState createState() => _FlashMemoryState();
}

class _FlashMemoryState extends State<FlashMemory> {
  late FlashMemoryController flashMemoryController;
  late FlashMemoryValueController flashMemoryValueController;

  @override
  void initState() {
    super.initState();
    flashMemoryController = Get.put(FlashMemoryController());
    flashMemoryValueController = Get.put(FlashMemoryValueController());
  }

  @override
  void dispose() {
    flashMemoryValueController.hardReset();
    Get.deleteAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Obx(() =>
      flashMemoryController.pages[flashMemoryController.page.value]);
}
