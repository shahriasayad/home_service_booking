import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/category_card.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_textfield.dart';
import '../../app/widgets/worker_card.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Home Service Booking",
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            CustomTextField(
              controller: controller.searchController,
              hintText: "Search worker...",
              prefixIcon: Icons.search,
              onChanged: controller.searchWorker,
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Obx(
                  () => SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 12),
                  itemBuilder: (_, index) {
                    final category = controller.categories[index];

                    return SizedBox(
                      width: 100,
                      child: CategoryCard(
                        category: category,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.category,
                            arguments: category.name,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Popular Workers",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.workers.length,
                  itemBuilder: (_, index) {
                    final worker = controller.workers[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: WorkerCard(
                        worker: worker,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.workerProfile,
                            arguments: worker,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}