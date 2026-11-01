import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class ProfileController extends GetxController {

  final name = "Nusrat Orpi".obs;
  final email = "orpi@gmail.com".obs;
  final phone = "+8801712345678".obs;
  final address = "Mymensingh, Bangladesh".obs;

  void editProfile() {
    Get.snackbar(
      "Coming Soon",
      "Edit Profile will be available soon.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void logout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textCancel: "Cancel",
      textConfirm: "Logout",
      onConfirm: () {
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}