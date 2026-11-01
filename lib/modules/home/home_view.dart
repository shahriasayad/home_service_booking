import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
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
      appBar: CustomAppBar(
        title: 'Home Service Booking',
        showBackButton: false,
        actions: [
          IconButton(
            tooltip: 'Select Area / Locality',
            icon: const Icon(Icons.location_on_outlined),
            onPressed: controller.showManualAreaDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: controller.searchController,
              hintText: 'Search by locality (e.g. Mymensingh), worker, or service...',
              prefixIcon: Icons.search,
              onChanged: controller.searchWorker,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 36,
              child: Obx(
                () {
                  final currentArea = controller.selectedArea.value;
                  final options = controller.areaOptions;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: options.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (_, index) {
                      final area = options[index];
                      final isSelected =
                          currentArea.toLowerCase() == area.toLowerCase();
                      return ChoiceChip(
                        avatar: Icon(
                          area == 'All Areas'
                              ? Icons.public
                              : Icons.place_outlined,
                          size: 16,
                          color: isSelected ? AppColors.primary : AppColors.grey,
                        ),
                        label: Text(area),
                        selected: isSelected,
                        onSelected: (_) => controller.selectArea(area),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.category),
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Obx(
              () => SizedBox(
                height: 106,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
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
            const SizedBox(height: 16),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.selectedArea.value == 'All Areas'
                        ? 'Available Workers (${controller.workers.length})'
                        : 'Workers in ${controller.selectedArea.value} (${controller.workers.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (controller.selectedArea.value != 'All Areas')
                    TextButton(
                      onPressed: () => controller.selectArea('All Areas'),
                      child: const Text('Show All Areas'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(
                () {
                  if (controller.workers.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person_search_outlined,
                            size: 56,
                            color: AppColors.grey,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No workers found for "${controller.selectedArea.value}"',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () {
                              controller.searchController.clear();
                              controller.searchWorker('');
                              controller.selectArea('All Areas');
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset Filters'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
