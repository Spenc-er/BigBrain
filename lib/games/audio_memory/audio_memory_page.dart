import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:game_template/games/audio_memory/controllers/number_memory_value_controller.dart';
import 'package:game_template/games/numbers_memory/controllers/share_pref.dart';
import 'package:get/get.dart';

import 'controllers/numbers_memory_controller.dart';


class AudioMemory extends StatefulWidget {
  final int lvl;
  AudioMemory({Key? key, required this.lvl}) : super(key: key);

  @override
  _AudioMemoryState createState() => _AudioMemoryState();
}

class _AudioMemoryState extends State<AudioMemory> {
  late AudioMemoryController controller;
  late AudioMemoryValueController valueController;

  @override
  void initState() {
    // Phone.closeStatusBar();

    var level = widget.lvl == 2
        ? 7
        : widget.lvl == 3
            ? 12
            : 1;
    controller = Get.put(AudioMemoryController());
    valueController = Get.put(AudioMemoryValueController(level));
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
