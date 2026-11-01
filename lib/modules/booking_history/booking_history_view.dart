import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/booking_card.dart';

import 'booking_history_controller.dart';

class BookingHistoryView
    extends GetView<BookingHistoryController> {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Booking History",
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Obx(
              () {
            if (controller.bookings.isEmpty) {
              return const Center(
                child: Text(
                  "No Booking Found",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: controller.bookings.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: BookingCard(
                    booking: controller.bookings[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}