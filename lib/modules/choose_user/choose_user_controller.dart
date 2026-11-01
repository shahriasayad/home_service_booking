import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class ChooseUserController extends GetxController {
  /// Selected Role
  final RxString selectedRole = ''.obs;

  /// Select Customer
  void selectCustomer() {
    selectedRole.value = 'Customer';
  }

  /// Select Worker
  void selectWorker() {
    selectedRole.value = 'Worker';
  }

  /// Continue Button
  void continueNext() {
    if (selectedRole.value.isEmpty) {
      Get.snackbar(
        'Warning',
        'Please select your role.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    Get.toNamed(
      AppRoutes.login,
      arguments: {
        'role': selectedRole.value,
      },
    );
  }

  /// Reset Selection (Optional)
  void clearSelection() {
    selectedRole.value = '';
  }
}