import 'package:get/get.dart';

import '../booking_history/booking_history_controller.dart';
import '../home/home_controller.dart';
import '../profile/profile_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<BookingHistoryController>(
      () => BookingHistoryController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
