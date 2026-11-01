import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/models/booking_model.dart';
import '../../app/data/models/worker_model.dart';
import '../../app/data/repositories/app_repository.dart';

class ReviewController extends GetxController {
  final reviewController = TextEditingController();
  final rating = 5.0.obs;
  final isSubmitting = false.obs;

  int workerId = 1;
  String workerName = 'Rakib Hasan';
  String bookingId = '';

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is Map) {
      final booking = args['booking'];
      final worker = args['worker'];
      if (booking is BookingModel) {
        workerId = booking.workerId;
        workerName = booking.workerName;
        bookingId = booking.id;
      } else if (worker is WorkerModel) {
        workerId = worker.id;
        workerName = worker.name;
      }
    } else if (args is BookingModel) {
      workerId = args.workerId;
      workerName = args.workerName;
      bookingId = args.id;
    } else if (args is WorkerModel) {
      workerId = args.id;
      workerName = args.name;
    }
  }

  void updateRating(double value) {
    rating.value = value;
  }

  Future<void> submitReview() async {
    final comment = reviewController.text.trim();
    if (comment.isEmpty) {
      Get.snackbar(
        'Review Required',
        'Please write a short feedback comment before submitting.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (isSubmitting.value) return;
    isSubmitting.value = true;

    final repo = AppRepository.to;
    final reviewerName = repo.currentUser.value?.name ?? 'Nusrat Orpi';

    await repo.addReview(
      workerId: workerId,
      workerName: workerName,
      bookingId: bookingId,
      userName: reviewerName,
      rating: rating.value.round(),
      comment: comment,
    );

    isSubmitting.value = false;

    Get.back();
    Get.snackbar(
      'Success',
      'Review submitted successfully for $workerName.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }
}
