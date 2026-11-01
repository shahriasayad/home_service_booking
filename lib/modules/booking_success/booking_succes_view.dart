import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_button.dart';

import 'booking_success_controller.dart';

class BookingSuccessView
    extends GetView<BookingSuccessController> {
  const BookingSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.check_circle,
                size: 120,
                color: Colors.green,
              ),

              const SizedBox(height: 25),

              const Text(
                "Booking Successful",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Your booking has been confirmed successfully.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              CustomButton(
                text: "Back to Home",
                onPressed: controller.goHome,
              ),
            ],
          ),
        ),
      ),
    );
  }
}