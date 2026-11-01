import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class ChooseUserController extends GetxController {
  final RxString selectedRole = 'Customer'.obs;

  void selectCustomer() {
    selectedRole.value = 'Customer';
  }

  void selectWorker() {
    selectedRole.value = 'Worker';
  }

  void selectAdmin() {
    selectedRole.value = 'Admin';
  }

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

  void clearSelection() {
    selectedRole.value = '';
  }
}
