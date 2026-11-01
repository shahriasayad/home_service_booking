import 'package:get/get.dart';

import 'worker_profile_controller.dart';

class WorkerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkerProfileController>(
          () => WorkerProfileController(),
    );
  }
}