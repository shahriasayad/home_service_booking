import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class AdminDashboardController extends GetxController {
  final totalWorkers = 50.obs;
  final totalCustomers = 120.obs;
  final totalBookings = 85.obs;
  final totalCategories = 10.obs;

  void goToManageWorkers() {
    Get.toNamed(AppRoutes.manageWorkers);
  }

  void goToManageCategories() {
    Get.toNamed(AppRoutes.manageCategories);
  }

  void logout() {
    Get.offAllNamed(AppRoutes.login);
  }
}