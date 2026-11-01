import 'package:get/get.dart';

import 'register_customer_controller.dart';

class RegisterCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterCustomerController>(
          () => RegisterCustomerController(),
    );
  }
}