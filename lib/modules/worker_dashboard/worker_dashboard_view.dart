import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import 'worker_dashboard_controller.dart';

class WorkerDashboardView extends GetView<WorkerDashboardController> {
  const WorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Worker Dashboard",
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

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person),
                ),
                title: const Text("Welcome"),
                subtitle: const Text("Professional Worker"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [

                  dashboardItem(
                    Icons.assignment,
                    "My Bookings",
                        () {
                      Get.toNamed(
                        '/worker-booking',
                      );
                    },
                  ),

                  dashboardItem(
                    Icons.schedule,
                    "Availability",
                        () {
                      Get.toNamed(
                        '/availability',
                      );
                    },
                  ),

                  dashboardItem(
                    Icons.star,
                    "Reviews",
                        () {},
                  ),

                  dashboardItem(
                    Icons.person,
                    "Profile",
                        () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "Bookings",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: "Availability",
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardItem(
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 40,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}