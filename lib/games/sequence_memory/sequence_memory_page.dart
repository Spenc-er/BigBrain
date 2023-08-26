import 'package:flutter/material.dart';
import 'package:game_template/games/numbers_memory/controllers/share_pref.dart';
import 'package:game_template/games/numbers_memory/controllers/store_controller.dart';
import 'package:get/get.dart';

import 'package:game_template/games/sequence_memory/controller/sequence_memory_controller.dart';
import 'package:game_template/games/sequence_memory/controller/sequence_memory_value_controller.dart';

class SequenceMemory extends StatefulWidget {
  SequenceMemory({Key? key}) : super(key: key);

  @override
  _SequenceMemoryState createState() => _SequenceMemoryState();
}

class _SequenceMemoryState extends State<SequenceMemory> {
  late SequenceMemoryController sequenceMemoryController;
  late SequenceMemoryValueController sequenceMemoryValueController;
  late StoreController controller;
  @override
  void initState() {
    sequenceMemoryController = Get.put(SequenceMemoryController());
    sequenceMemoryValueController = Get.put(SequenceMemoryValueController());
    controller = Get.put(StoreController());
    AppSharedPref.initSessionManager();
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  void dispose() {
    sequenceMemoryValueController.hardReset();
    Get.deleteAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Obx(() =>
      sequenceMemoryController.pages[sequenceMemoryController.page.value]);
}
