import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import 'worker_dashboard_controller.dart';

class WorkerDashboardView extends GetView<WorkerDashboardController> {
  const WorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Worker Dashboard',
        showBackButton: false,
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Obx(
          () {
            final worker = controller.currentWorker.value;
            final bookings = controller.workerBookings;
            final pendingCount =
                bookings.where((b) => b.status == 'Pending').length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                worker?.image ?? 'assets/images/worker1.png',
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => const CircleAvatar(
                                  radius: 28,
                                  child: Icon(Icons.person),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    worker?.name ?? 'Professional Worker',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    worker?.serviceCategories.join(' • ') ??
                                        'Home Service Provider',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Areas: ${worker?.serviceAreas.join(', ') ?? 'Mymensingh'}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: (worker?.isAvailable ?? true)
                                    ? AppColors.success.withValues(alpha: 0.12)
                                    : AppColors.grey.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                (worker?.isAvailable ?? true)
                                    ? 'Available'
                                    : 'Busy',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: (worker?.isAvailable ?? true)
                                      ? AppColors.success
                                      : AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.2,
                    children: [
                      dashboardItem(
                        icon: Icons.assignment,
                        title: 'Booking Requests',
                        subtitle: '$pendingCount Pending • ${bookings.length} Total',
                        onTap: () => Get.toNamed(AppRoutes.workerBooking),
                      ),
                      dashboardItem(
                        icon: Icons.schedule,
                        title: 'Availability',
                        subtitle: worker != null
                            ? '${worker.startTime} - ${worker.endTime}'
                            : 'Manage Hours & Days',
                        onTap: () => Get.toNamed(AppRoutes.availability),
                      ),
                      dashboardItem(
                        icon: Icons.star_rounded,
                        title: 'Reviews & Rating',
                        subtitle:
                            '${worker?.rating.toStringAsFixed(1) ?? '4.8'} ★ (${controller.workerReviews.length} reviews)',
                        onTap: controller.openMyReviews,
                      ),
                      dashboardItem(
                        icon: Icons.manage_accounts,
                        title: 'Manage Profile',
                        subtitle: 'Categories, Areas & Charge',
                        onTap: controller.openManageProfile,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Availability',
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: Card(
        elevation: AppSizes.cardElevation,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Icon(
                  icon,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
