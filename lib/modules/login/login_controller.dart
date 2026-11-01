import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class LoginController extends GetxController {
  // Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // User Role (Customer / Worker)
  late final String role;

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable Variables
  final RxBool isPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Receive role from Choose User screen
    role = Get.arguments?['role'] ?? 'Customer';
  }

  // Show / Hide Password
  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Login
  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    // Dummy API Delay
    await Future.delayed(
      const Duration(seconds: 2),
    );

    isLoading.value = false;

    // Navigate according to role
    if (role == "Customer") {
      Get.offAllNamed(
        AppRoutes.dashboard,
      );
    } else if (role == "Worker") {
      Get.offAllNamed(
        AppRoutes.workerDashboard,
      );
    } else {
      Get.snackbar(
        "Error",
        "Invalid user role.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Navigate to Register Screen
  void goToRegister() {
    if (role == "Customer") {
      Get.toNamed(
        AppRoutes.registerCustomer,
      );
    } else {
      Get.toNamed(
        AppRoutes.registerWorker,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}