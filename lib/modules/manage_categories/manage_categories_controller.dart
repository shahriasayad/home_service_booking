import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/models/category_model.dart';
import '../../app/data/repositories/app_repository.dart';

class ManageCategoriesController extends GetxController {
  final categories = <CategoryModel>[].obs;
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final repo = AppRepository.to;
    categories.assignAll(repo.categories);

    ever<List<CategoryModel>>(repo.categories, (list) {
      categories.assignAll(list);
    });
  }

  Future<void> addCategory() async {
    final name = categoryController.text.trim();

    if (name.isEmpty) {
      Get.snackbar(
        'Warning',
        'Please enter a category name.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    await AppRepository.to.addCategory(
      name: name,
      description: descriptionController.text.trim(),
    );

    categoryController.clear();
    descriptionController.clear();

    Get.back();

    Get.snackbar(
      'Success',
      'Category added successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deleteCategory(int index) {
    if (index < 0 || index >= categories.length) return;
    final category = categories[index];

    Get.defaultDialog(
      title: 'Delete Category',
      middleText: 'Are you sure you want to delete ${category.name}?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await AppRepository.to.deleteCategory(category.id);

        Get.back();

        Get.snackbar(
          'Deleted',
          '${category.name} deleted successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showAddCategoryDialog() {
    categoryController.clear();
    descriptionController.clear();
    Get.dialog(
      AlertDialog(
        title: const Text('Add Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                hintText: 'Category name',
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description (optional)',
                prefixIcon: Icon(Icons.description_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              categoryController.clear();
              descriptionController.clear();
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: addCategory,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void showEditCategoryDialog(CategoryModel category) {
    categoryController.text = category.name;
    descriptionController.text = category.description;
    Get.dialog(
      AlertDialog(
        title: const Text('Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category name',
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = categoryController.text.trim();
              if (name.isEmpty) return;
              await AppRepository.to.updateCategory(
                category.copyWith(
                  name: name,
                  description: descriptionController.text.trim(),
                ),
              );
              Get.back();
              Get.snackbar(
                'Updated',
                'Category updated successfully.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    categoryController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
