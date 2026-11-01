import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import 'admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Admin Dashboard',
        showBackButton: false,
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.25,
                children: [
                  dashboardCard(
                    'Workers',
                    controller.totalWorkers.toString(),
                    Icons.engineering,
                    onTap: controller.goToManageWorkers,
                  ),
                  dashboardCard(
                    'Customers',
                    controller.totalCustomers.toString(),
                    Icons.people,
                    onTap: controller.openManageUsersSheet,
                  ),
                  dashboardCard(
                    'Bookings',
                    controller.totalBookings.toString(),
                    Icons.calendar_month,
                    onTap: controller.openMonitorActivitySheet,
                  ),
                  dashboardCard(
                    'Categories',
                    controller.totalCategories.toString(),
                    Icons.category,
                    onTap: controller.goToManageCategories,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Administration Controls',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.people, color: AppColors.primary),
                    title: const Text('Manage Users'),
                    subtitle: const Text('View, suspend/activate or remove customer accounts'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: controller.openManageUsersSheet,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading:
                        const Icon(Icons.engineering, color: AppColors.primary),
                    title: const Text('Manage Workers'),
                    subtitle: const Text('Approve, reject, search & manage service providers'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: controller.goToManageWorkers,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading:
                        const Icon(Icons.category, color: AppColors.primary),
                    title: const Text('Manage Service Categories'),
                    subtitle: const Text('Add, edit or remove service categories'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: controller.goToManageCategories,
                  ),
                  const Divider(height: 1),
                  Obx(
                    () => ListTile(
                      leading: const Icon(
                        Icons.analytics_outlined,
                        color: AppColors.primary,
                      ),
                      title: const Text('Monitor Reviews & System Activity'),
                      subtitle: Text(
                        '${controller.totalReviews} Reviews • ${controller.totalBookings} Bookings • Payments',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: controller.openMonitorActivitySheet,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
    String title,
    String count,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: Card(
        elevation: AppSizes.cardElevation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 34,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
