import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class WorkerDashboardController extends GetxController {

  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;

    switch (index) {
      case 0:
        break;

      case 1:
        Get.toNamed(AppRoutes.workerBooking);
        break;

      case 2:
        Get.toNamed(AppRoutes.availability);
        break;
    }
  }

  void logout() {
    Get.offAllNamed(AppRoutes.login);
  }
}