import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/models/booking_model.dart';
import '../../app/data/models/payment_model.dart';
import '../../app/data/models/worker_model.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';
import '../../app/utils/date_formatter.dart';

class PaymentController extends GetxController {
  final selectedIndex = 0.obs;
  final isProcessing = false.obs;

  /// Simulated outcome for bKash & Nagad ('Success', 'Pending', 'Failed', 'Cancelled')
  final simulatedOutcome = 'Success'.obs;
  final walletAccountController = TextEditingController();

  late BookingModel bookingDraft;

  final paymentMethods = <PaymentModel>[].obs;

  PaymentModel get selectedMethod => paymentMethods[selectedIndex.value];

  bool get isMobileWallet =>
      selectedMethod.title.toLowerCase() == 'bkash' ||
      selectedMethod.title.toLowerCase() == 'nagad';

  @override
  void onInit() {
    super.onInit();
    paymentMethods.assignAll(DummyData.payments);

    final repo = AppRepository.to;
    final arg = Get.arguments;

    if (arg is BookingModel) {
      bookingDraft = arg;
    } else if (repo.draftBooking.value != null) {
      bookingDraft = repo.draftBooking.value!;
    } else if (arg is WorkerModel) {
      bookingDraft = BookingModel(
        workerId: arg.id,
        workerName: arg.name,
        profession: arg.profession,
        date: DateFormatter.formatDate(DateTime.now().add(const Duration(days: 1))),
        time: '10:00 AM',
        status: 'Pending',
        image: arg.image,
        amount: arg.price,
      );
    } else {
      bookingDraft = BookingModel(
        workerId: 1,
        workerName: 'Rakib Hasan',
        profession: 'Electrician',
        date: DateFormatter.formatDate(DateTime.now().add(const Duration(days: 1))),
        time: '10:00 AM',
        status: 'Pending',
        image: 'assets/images/worker1.png',
        amount: 600,
      );
    }

    walletAccountController.text = bookingDraft.customerPhone;
  }

  void selectPayment(int index) {
    selectedIndex.value = index;
  }

  void setSimulatedOutcome(String outcome) {
    simulatedOutcome.value = outcome;
  }

  Future<void> confirmPayment() async {
    if (isProcessing.value) return;

    final repo = AppRepository.to;
    if (repo.hasSuccessfulPaymentForBooking(bookingDraft.id)) {
      Get.snackbar(
        'Duplicate Payment Prevented',
        'This booking has already been paid.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final method = selectedMethod.title;
    if (isMobileWallet && walletAccountController.text.trim().length < 11) {
      Get.snackbar(
        'Invalid Mock Account',
        'Please enter an 11-digit simulated mobile number.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    isProcessing.value = true;
    await Future.delayed(const Duration(milliseconds: 600));

    try {
      final outcome = isMobileWallet ? simulatedOutcome.value : 'Pay on Service';
      final record = await repo.processBookingPayment(
        booking: bookingDraft,
        paymentMethod: method,
        simulatedOutcome: outcome,
        simulatedAccount: walletAccountController.text.trim(),
      );

      isProcessing.value = false;

      if (record.status == 'Failed') {
        Get.snackbar(
          'Simulated Payment Failed',
          'Mock $method transaction (${record.transactionRef}) failed. Please retry or choose another payment method.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (record.status == 'Cancelled') {
        Get.snackbar(
          'Simulated Payment Cancelled',
          'You cancelled the simulated $method payment. Booking was not finalized.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      Get.offAllNamed(
        AppRoutes.bookingSuccess,
        arguments: repo.lastConfirmedBooking.value,
      );
    } catch (e) {
      isProcessing.value = false;
      Get.snackbar(
        'Payment Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    walletAccountController.dispose();
    super.onClose();
  }
}
