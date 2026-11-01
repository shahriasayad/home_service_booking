import 'package:get/get.dart';

import '../../app/data/models/booking_model.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';

class BookingSuccessController extends GetxController {
  BookingModel? get confirmedBooking {
    if (Get.arguments is BookingModel) {
      return Get.arguments as BookingModel;
    }
    return AppRepository.to.lastConfirmedBooking.value;
  }

  void goHome() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void goToBookingHistory() {
    Get.offAllNamed(AppRoutes.dashboard);
    Get.toNamed(AppRoutes.bookingHistory);
  }
}
