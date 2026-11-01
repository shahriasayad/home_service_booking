import 'package:get/get.dart';

import '../../app/data/models/booking_model.dart';
import '../../app/data/repositories/app_repository.dart';

class WorkerBookingController extends GetxController {
  final bookings = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    _syncBookings();
    ever<List<BookingModel>>(
      AppRepository.to.bookings,
      (_) => _syncBookings(),
    );
  }

  void _syncBookings() {
    final repo = AppRepository.to;
    final currentWorker = repo.currentWorker.value;
    if (currentWorker != null) {
      final matched = repo.bookings
          .where(
            (b) =>
                b.workerId == currentWorker.id ||
                b.workerName.toLowerCase() == currentWorker.name.toLowerCase(),
          )
          .toList();
      if (matched.isNotEmpty) {
        bookings.assignAll(matched);
        return;
      }
    }
    bookings.assignAll(repo.bookings);
  }

  Future<void> acceptBooking(int index) async {
    if (index < 0 || index >= bookings.length) return;
    final booking = bookings[index];
    await AppRepository.to.updateBookingStatus(booking.id, 'Accepted');

    Get.snackbar(
      'Success',
      'Booking accepted for ${booking.customerName}.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> rejectBooking(int index) async {
    if (index < 0 || index >= bookings.length) return;
    final booking = bookings[index];
    await AppRepository.to.updateBookingStatus(booking.id, 'Rejected');

    Get.snackbar(
      'Rejected',
      'Booking request has been rejected.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> completeBooking(int index) async {
    if (index < 0 || index >= bookings.length) return;
    final booking = bookings[index];
    await AppRepository.to.updateBookingStatus(booking.id, 'Completed');

    Get.snackbar(
      'Service Completed',
      'Booking marked as Completed and payment settled.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
