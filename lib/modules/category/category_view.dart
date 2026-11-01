import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/category_card.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/worker_card.dart';
import 'category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Service Categories',
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
              child: Obx(
                () {
                  final currentCat = controller.selectedCategory.value;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (_, index) {
                      final category = controller.categories[index];
                      return SizedBox(
                        width: 100,
                        child: CategoryCard(
                          category: category,
                          isSelected: currentCat.toLowerCase() ==
                              category.name.toLowerCase(),
                          onTap: () {
                            controller.filterWorkers(category.name);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: Obx(
                () {
                  final currentArea = controller.selectedArea.value;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.areaOptions.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (_, index) {
                      final area = controller.areaOptions[index];
                      final isSelected =
                          currentArea.toLowerCase() == area.toLowerCase();
                      return ChoiceChip(
                        label: Text(area),
                        selected: isSelected,
                        onSelected: (_) => controller.selectArea(area),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Obx(
                () {
                  if (controller.workers.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.engineering_outlined,
                            size: 56,
                            color: AppColors.grey,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No workers found for this filter.',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              controller.selectedCategory.value = '';
                              controller.selectArea('All Areas');
                            },
                            child: const Text('Clear Filters'),
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
