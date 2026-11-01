import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/booking_card.dart';
import '../../app/widgets/custom_appbar.dart';
import 'booking_history_controller.dart';

class BookingHistoryView extends GetView<BookingHistoryController> {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Booking History',
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            SizedBox(
              height: 38,
              child: Obx(
                () {
                  final active = controller.selectedStatus.value;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.statusFilters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (_, index) {
                      final status = controller.statusFilters[index];
                      return ChoiceChip(
                        label: Text(status),
                        selected: active == status,
                        onSelected: (_) => controller.filterByStatus(status),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Obx(
                () {
                  if (controller.bookings.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.event_busy_outlined,
                            size: 56,
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No Booking Found',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.bookings.length,
                    itemBuilder: (_, index) {
                      final booking = controller.bookings[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: BookingCard(
                          booking: booking,
                          onCancelTap: () => controller.cancelBooking(booking),
                          onReviewTap: () => controller.openReview(booking),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
