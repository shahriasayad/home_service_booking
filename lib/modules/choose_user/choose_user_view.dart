import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/widgets/custom_button.dart';

import 'choose_user_controller.dart';

class ChooseUserView extends GetView<ChooseUserController> {
  const ChooseUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Choose User"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),

        child: Column(
          children: [

            const SizedBox(height: 30),

            Text(
              "Select Your Role",
              style: AppTextStyles.heading,
            ),

            const SizedBox(height: 30),

            Obx(() => roleCard(
              title: "Customer",
              icon: Icons.person,
              selected:
              controller.selectedRole.value ==
                  "Customer",
              onTap: controller.selectCustomer,
            )),

            const SizedBox(height: 20),

            Obx(() => roleCard(
              title: "Worker",
              icon: Icons.home_repair_service,
              selected:
              controller.selectedRole.value ==
                  "Worker",
              onTap: controller.selectWorker,
            )),

            const Spacer(),

            CustomButton(
              text: "Continue",
              onPressed: controller.continueNext,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget roleCard({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius:
      BorderRadius.circular(AppSizes.cardRadius),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(.08)
              : Colors.white,
          borderRadius:
          BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.border,
            width: 2,
          ),
        ),
        child: Row(
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor:
              AppColors.primary.withOpacity(.12),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Text(
                title,
                style: AppTextStyles.title,
              ),
            ),

            if (selected)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}