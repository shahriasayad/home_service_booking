import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class CustomDialog {
  CustomDialog._();

  static void show({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      radius: 12,
      textCancel: "Cancel",
      content: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Confirm",
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}