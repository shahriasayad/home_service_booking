import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import 'admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Admin Dashboard",
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            Obx(
                  () => GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  dashboardCard(
                    "Workers",
                    controller.totalWorkers.value.toString(),
                    Icons.engineering,
                  ),
                  dashboardCard(
                    "Customers",
                    controller.totalCustomers.value.toString(),
                    Icons.people,
                  ),
                  dashboardCard(
                    "Bookings",
                    controller.totalBookings.value.toString(),
                    Icons.calendar_month,
                  ),
                  dashboardCard(
                    "Categories",
                    controller.totalCategories.value.toString(),
                    Icons.category,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            ListTile(
              leading: const Icon(Icons.engineering),
              title: const Text("Manage Workers"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: controller.goToManageWorkers,
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.category),
              title: const Text("Manage Categories"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: controller.goToManageCategories,
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
      String title,
      String count,
      IconData icon,
      ) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            count,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}