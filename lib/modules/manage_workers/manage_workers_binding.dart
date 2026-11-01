import 'package:get/get.dart';

import 'manage_workers_controller.dart';

class ManageWorkersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageWorkersController>(
          () => ManageWorkersController(),
    );
  }
}