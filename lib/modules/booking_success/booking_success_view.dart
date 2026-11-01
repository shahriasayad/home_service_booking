import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_button.dart';
import 'booking_success_controller.dart';

class BookingSuccessView extends GetView<BookingSuccessController> {
  const BookingSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = controller.confirmedBooking;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 110,
                  color: AppColors.success,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Booking Successful',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your service booking request has been confirmed and saved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.grey),
                ),
                if (booking != null) ...[
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.md),
                      child: Column(
                        children: [
                          _infoRow('Booking ID', booking.id),
                          const Divider(height: 16),
                          _infoRow('Worker', '${booking.workerName} (${booking.profession})'),
                          const Divider(height: 16),
                          _infoRow('Date & Time', '${booking.date} • ${booking.time}'),
                          const Divider(height: 16),
                          _infoRow('Payment Method', booking.paymentMethod),
                          const Divider(height: 16),
                          _infoRow('Payment Status', booking.paymentStatus),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Back to Home',
                  onPressed: controller.goHome,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: controller.goToBookingHistory,
                  child: const Text('View Booking History'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.grey, fontSize: 13),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
