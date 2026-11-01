import 'package:get/get.dart';

import 'worker_dashboard_controller.dart';

class WorkerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkerDashboardController>(
          () => WorkerDashboardController(),
    );
  }
}