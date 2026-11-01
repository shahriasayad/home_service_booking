import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/theme_controller.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  Widget buildItem(
    IconData icon,
    String title,
    String value, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: AppColors.primary),
          title: Text(
            title,
            style: const TextStyle(fontSize: 13, color: AppColors.grey),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing:
              onTap != null ? const Icon(Icons.chevron_right) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Profile',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                  child: const Icon(
                    Icons.person,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Obx(
              () => Text(
                controller.name.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Obx(
              () => Text(
                'Locality: ${controller.area.value}',
                style: const TextStyle(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => buildItem(
                Icons.email_outlined,
                'Email',
                controller.email.value,
              ),
            ),
            Obx(
              () => buildItem(
                Icons.phone_outlined,
                'Phone',
                controller.phone.value,
              ),
            ),
            Obx(
              () => buildItem(
                Icons.map_outlined,
                'Area / Locality',
                controller.area.value,
              ),
            ),
            Obx(
              () => buildItem(
                Icons.location_on_outlined,
                'Street Address',
                controller.address.value,
              ),
            ),
            if (Get.isRegistered<ThemeController>())
              Obx(
                () => buildItem(
                  Icons.brightness_6_outlined,
                  'Theme Appearance',
                  ThemeController.to.currentThemeLabel,
                  onTap: controller.openThemeSettings,
                ),
              ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Edit Profile',
              icon: Icons.edit_outlined,
              onPressed: controller.editProfile,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Logout',
              icon: Icons.logout,
              backgroundColor: AppColors.error,
              onPressed: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}
