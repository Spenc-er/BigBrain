import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  final startTime = "".obs;
  final _db = FirebaseFirestore.instance;

  updateTime(String name) {
    startTime(name);
    update();
  }

  createSurvey(data) async {


    await _db
        .collection("users")
        .add(data)
        .whenComplete(() => Get.snackbar(
              "Success",
              "Survey has been created.",
              snackPosition: SnackPosition.BOTTOM,
            ))
        .catchError((error) {
      Get.snackbar(
        "Error",
        "Something went wrong, please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    });


  }
}
