import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppToast {
  static void snackBar(String type, String message) async {
    Get.snackbar(type, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white));
  }
}
