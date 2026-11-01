import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
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
        title: "Categories",
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),

        child: Column(
          children: [

            SizedBox(
              height: 110,

              child: Obx(
                    () => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,

                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 12),

                  itemBuilder: (_, index) {

                    final category =
                    controller.categories[index];

                    return SizedBox(
                      width: 100,

                      child: CategoryCard(
                        category: category,

                        onTap: () {
                          controller.filterWorkers(
                            category.name,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.workers.length,

                  itemBuilder: (_, index) {

                    return Padding(
                      padding:
                      const EdgeInsets.only(bottom: 12),

                      child: WorkerCard(
                        worker: controller.workers[index],

                        onTap: () {

                          Get.toNamed(
                            AppRoutes.workerProfile,
                            arguments:
                            controller.workers[index],
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