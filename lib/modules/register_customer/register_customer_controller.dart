import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class RegisterCustomerController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  // Observable Variables
  final RxBool hidePassword = true.obs;
  final RxBool hideConfirmPassword = true.obs;
  final RxBool isLoading = false.obs;

  // Toggle Password Visibility
  void togglePassword() {
    hidePassword.value = !hidePassword.value;
  }

  // Toggle Confirm Password Visibility
  void toggleConfirmPassword() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  // Register Customer
  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    // Dummy API Delay
    await Future.delayed(
      const Duration(seconds: 2),
    );

    isLoading.value = false;

    // Navigate to Customer Dashboard
    Get.offAllNamed(
      AppRoutes.dashboard,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}