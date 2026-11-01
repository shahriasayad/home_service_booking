import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {
  Helper._();

  static void showSnackBar({
    required String title,
    required String message,
    Color backgroundColor = Colors.green,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 2),
    );
  }

  static void showLoading() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static void unfocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}