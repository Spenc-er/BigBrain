import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';

import '/games/numbers_memory/controllers/number_memory_value_controller.dart';

import 'controllers/numbers_memory_controller.dart';
import 'controllers/share_pref.dart';

class NumbersMemory extends StatefulWidget {
  final int lvl;
  NumbersMemory({Key? key, required this.lvl}) : super(key: key);

  @override
  _NumbersMemoryState createState() => _NumbersMemoryState();
}

class _NumbersMemoryState extends State<NumbersMemory> {
  late NumbersMemoryController controller;
  late NumbersMemoryValueController valueController;

  @override
  void initState() {
    // Phone.closeStatusBar();

    var level = widget.lvl == 2
        ? 7
        : widget.lvl == 3
            ? 12
            : 1;
    controller = Get.put(NumbersMemoryController());
    valueController = Get.put(NumbersMemoryValueController(level));
    WidgetsFlutterBinding.ensureInitialized();
    AppSharedPref.initSessionManager();
    super.initState();
  }

  @override
  void dispose() {
    var level = widget.lvl == 2
        ? 7
        : widget.lvl == 3
            ? 12
            : 1;

    controller.reset(level);
    Get.deleteAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: () => _focusLostController(),
      child: Obx(
        () => controller.pages[controller.page.value],
      ),
    );
  }

  _focusLostController() {
    if (controller.onShowNumberPage) {
      if (!controller.protectedFocusLost) {
        Get.back();
        Get.snackbar(
          "Game Over",
          "If you leave while playing, the game is over.",
          duration: Duration(seconds: 5),
        );
      } else {
        controller.protectedFocusLost = false;
      }
    }
  }
}
