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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            children: [
              const Spacer(),
              Container(
                height: 240,
                width: 240,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/worker1.png',
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.handyman_rounded,
                      size: 100,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              const Text(
                'Trusted Home Services',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 14),
              const Text(
                'Book verified electricians, plumbers, cleaners, painters, and AC technicians right in your locality.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Get Started',
                onPressed: controller.goToChooseUser,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
