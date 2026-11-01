import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';

import 'manage_categories_controller.dart';

class ManageCategoriesView
    extends GetView<ManageCategoriesController> {
  const ManageCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Manage Categories",
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.showAddCategoryDialog,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Obx(
              () {
            if (controller.categories.isEmpty) {
              return const Center(
                child: Text(
                  "No categories found.",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            }

            return ListView.separated(
              itemCount: controller.categories.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 10),

              itemBuilder: (_, index) {
                final category =
                controller.categories[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.asset(
                        category.icon,
                        width: 30,
                        height: 30,
                        errorBuilder:
                            (_, __, ___) {
                          return const Icon(
                            Icons.category,
                          );
                        },
                      ),
                    ),

                    title: Text(
                      category.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    trailing: IconButton(
                      onPressed: () {
                        controller.deleteCategory(
                          index,
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}