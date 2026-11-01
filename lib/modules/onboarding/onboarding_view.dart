import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/widgets/custom_button.dart';

import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.white,

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(AppSizes.md),

          child: Column(

            children: [

              const Spacer(),

              Image.asset(
                "assets/images/onboarding.png",
                height: 280,
              ),

              const SizedBox(height: 40),

              Text(
                "Trusted Home Services",
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 15),

              const Text(
                "Book electricians, plumbers, cleaners, painters and many more professionals at your doorstep.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),

              const Spacer(),

              CustomButton(
                text: "Get Started",
                onPressed: controller.goToChooseUser,
              ),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}