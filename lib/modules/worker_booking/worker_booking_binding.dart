import 'package:get/get.dart';

import 'worker_booking_controller.dart';

class WorkerBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkerBookingController>(
          () => WorkerBookingController(),
    );
  }
}