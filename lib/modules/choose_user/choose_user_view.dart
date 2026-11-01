import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import 'choose_user_controller.dart';

class ChooseUserView extends GetView<ChooseUserController> {
  const ChooseUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Choose User Role',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Select Your Role',
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 6),
              const Text(
                'Continue as a Customer, Service Worker, or System Admin',
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => roleCard(
                          context: context,
                          title: 'Customer',
                          subtitle: 'Browse categories, search by locality & book services',
                          icon: Icons.person,
                          selected: controller.selectedRole.value == 'Customer',
                          onTap: controller.selectCustomer,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => roleCard(
                          context: context,
                          title: 'Worker',
                          subtitle: 'Manage service profile, locality areas & booking requests',
                          icon: Icons.home_repair_service,
                          selected: controller.selectedRole.value == 'Worker',
                          onTap: controller.selectWorker,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => roleCard(
                          context: context,
                          title: 'Admin',
                          subtitle: 'Manage users, workers, categories & monitor system activity',
                          icon: Icons.admin_panel_settings,
                          selected: controller.selectedRole.value == 'Admin',
                          onTap: controller.selectAdmin,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Continue',
                onPressed: controller.continueNext,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget roleCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.08)
              : theme.cardColor,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(
            color: selected ? AppColors.primary : theme.dividerColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.primary.withValues(alpha: 0.14),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.title,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.body.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
              ),
          ],
        ),
      ),
    );
  }
}
