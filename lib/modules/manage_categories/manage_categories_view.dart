import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import 'manage_categories_controller.dart';

class ManageCategoriesView extends GetView<ManageCategoriesController> {
  const ManageCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Manage Categories',
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
                  'No categories found.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.separated(
              itemCount: controller.categories.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, index) {
                final category = controller.categories[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                      child: Image.asset(
                        category.icon,
                        width: 28,
                        height: 28,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.category,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    title: Text(
                      category.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: category.description.isNotEmpty
                        ? Text(
                            category.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.showEditCategoryDialog(category);
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.deleteCategory(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.error,
                          ),
                        ),
                      ],
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
