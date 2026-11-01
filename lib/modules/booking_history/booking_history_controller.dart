import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/models/booking_model.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';

class BookingHistoryController extends GetxController {
  final bookings = <BookingModel>[].obs;
  final selectedStatus = 'All'.obs;

  final List<String> statusFilters = const [
    'All',
    'Pending',
    'Accepted',
    'Completed',
    'Cancelled',
    'Rejected',
  ];

  @override
  void onInit() {
    super.onInit();

    final repo = AppRepository.to;
    _applyFilter();

    ever<List<BookingModel>>(repo.bookings, (_) => _applyFilter());
    ever(repo.currentUser, (_) => _applyFilter());
  }

  void filterByStatus(String status) {
    selectedStatus.value = status;
    _applyFilter();
  }

  void _applyFilter() {
    final repo = AppRepository.to;
    final currentUser = repo.currentUser.value;
    List<BookingModel> baseList = repo.bookings;
    if (currentUser != null && repo.currentRole.value == 'Customer') {
      final userBookings = repo.bookings
          .where(
            (b) =>
                b.customerId == currentUser.id ||
                b.customerName.toLowerCase() == currentUser.name.toLowerCase(),
          )
          .toList();
      if (userBookings.isNotEmpty) {
        baseList = userBookings;
      }
    }

    final filter = selectedStatus.value;
    if (filter == 'All') {
      bookings.assignAll(baseList);
    } else {
      bookings.assignAll(
        baseList.where((b) => b.status.toLowerCase() == filter.toLowerCase()),
      );
    }
  }

  void cancelBooking(BookingModel booking) {
    Get.defaultDialog(
      title: 'Cancel Booking',
      middleText:
          'Are you sure you want to cancel your booking with ${booking.workerName}?',
      textCancel: 'No',
      textConfirm: 'Yes, Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await AppRepository.to.updateBookingStatus(booking.id, 'Cancelled');
        Get.back();
        Get.snackbar(
          'Booking Cancelled',
          'Your booking has been cancelled.',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void openReview(BookingModel booking) {
    Get.toNamed(
      AppRoutes.review,
      arguments: {
        'booking': booking,
      },
    );
  }
}
