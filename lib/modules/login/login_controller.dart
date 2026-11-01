import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxString role = 'Customer'.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final argRole = Get.arguments is Map ? Get.arguments['role']?.toString() : null;
    role.value = (argRole != null && argRole.isNotEmpty) ? argRole : 'Customer';
    fillDemoCredentials(role.value);
  }

  void setRole(String selectedRole) {
    role.value = selectedRole;
    fillDemoCredentials(selectedRole);
  }

  void fillDemoCredentials(String targetRole) {
    if (targetRole == 'Worker') {
      emailController.text = 'rakib@worker.com';
      passwordController.text = 'password123';
    } else if (targetRole == 'Admin') {
      emailController.text = 'admin@homeservice.com';
      passwordController.text = 'admin123';
    } else {
      emailController.text = 'orpi@gmail.com';
      passwordController.text = 'password123';
    }
  }

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 500));

    final errorMessage = await AppRepository.to.login(
      email: emailController.text,
      password: passwordController.text,
      role: role.value,
    );

    isLoading.value = false;

    if (errorMessage != null) {
      Get.snackbar(
        'Login Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (role.value == 'Customer') {
      Get.offAllNamed(AppRoutes.dashboard);
    } else if (role.value == 'Worker') {
      Get.offAllNamed(AppRoutes.workerDashboard);
    } else if (role.value == 'Admin') {
      Get.offAllNamed(AppRoutes.adminDashboard);
    } else {
      Get.snackbar(
        'Error',
        'Invalid user role.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void goToRegister() {
    if (role.value == 'Customer') {
      Get.toNamed(AppRoutes.registerCustomer);
    } else if (role.value == 'Worker') {
      Get.toNamed(AppRoutes.registerWorker);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
