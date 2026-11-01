import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class BookingSuccessController extends GetxController {

  void goHome() {
    Get.offAllNamed(
      AppRoutes.dashboard,
    );
  }

}