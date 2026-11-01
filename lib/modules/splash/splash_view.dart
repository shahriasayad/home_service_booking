import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [

              Lottie.asset(
                "assets/animations/splash.json",
                height: 220,
              ),

              const SizedBox(height: 25),

              Text(
                "Home Service Booking",
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 10),

              const Text(
                "Find Trusted Service Providers",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 50),

              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}