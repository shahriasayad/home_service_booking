import 'package:get/get.dart';

import '../../app/data/models/payment_model.dart';
import '../../app/routes/app_routes.dart';

class PaymentController extends GetxController {
  final selectedIndex = 0.obs;

  final paymentMethods = <PaymentModel>[
    PaymentModel(
      title: "bKash",
      icon: "assets/icons/bkash.png",
    ),
    PaymentModel(
      title: "Nagad",
      icon: "assets/icons/nagad.png",
    ),
    PaymentModel(
      title: "Cash on Service",
      icon: "assets/icons/cash.png",
    ),
  ].obs;

  void selectPayment(int index) {
    selectedIndex.value = index;
  }

  void confirmPayment() {
    Get.offAllNamed(
      AppRoutes.bookingSuccess,
    );
  }
}