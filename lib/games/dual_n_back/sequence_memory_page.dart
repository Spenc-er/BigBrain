import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:game_template/helpers/phone_properties.dart';
import 'package:game_template/games/dual_n_back/controller/sequence_memory_controller.dart';
import 'package:game_template/games/dual_n_back/controller/sequence_memory_value_controller.dart';

class DualNBack extends StatefulWidget {
  DualNBack({Key? key}) : super(key: key);

  @override
  _DualNBackState createState() => _DualNBackState();
}

class _DualNBackState extends State<DualNBack> {
  late DualNBackController dualNBackController;
  late DualNBackValueController dualNBackValueController;

  @override
  void initState() {
    super.initState();
    dualNBackController = Get.put(DualNBackController());
    dualNBackValueController = Get.put(DualNBackValueController());
  }

  @override
  void dispose() {
    dualNBackValueController.hardReset();
    Get.deleteAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Obx(() =>
      dualNBackController.pages[dualNBackController.page.value]);
}
