import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  final reviewController = TextEditingController();

  final rating = 5.0.obs;

  void updateRating(double value) {
    rating.value = value;
  }

  void submitReview() {
    Get.snackbar(
      "Success",
      "Review submitted successfully.",
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.back();
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }
}