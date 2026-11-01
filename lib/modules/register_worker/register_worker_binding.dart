import 'package:get/get.dart';

import 'register_worker_controller.dart';

class RegisterWorkerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterWorkerController>(
          () => RegisterWorkerController(),
    );
  }
}