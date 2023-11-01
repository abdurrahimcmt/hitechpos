import 'dart:core';
import 'package:get/get.dart';

class CustomNotification {
  void notification(String title, String message, String position){
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }
}

