import 'package:get/get.dart';

class StoreController extends GetxController {
  final startTime = "".obs;

  updateTime(String name) {
    startTime(name);
    update();
  }
}
