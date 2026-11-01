import 'package:get/get.dart';

import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Future.delayed(
      const Duration(seconds: 2),
      _navigateNext,
    );
  }

  void _navigateNext() {
    final role = AppRepository.to.currentRole.value;
    if (role == 'Customer') {
      Get.offAllNamed(AppRoutes.dashboard);
    } else if (role == 'Worker') {
      Get.offAllNamed(AppRoutes.workerDashboard);
    } else if (role == 'Admin') {
      Get.offAllNamed(AppRoutes.adminDashboard);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
