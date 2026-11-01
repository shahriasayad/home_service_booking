import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/models/category_model.dart';

class ManageCategoriesController extends GetxController {
  final categories = <CategoryModel>[].obs;

  final categoryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    categories.assignAll(
      DummyData.categories,
    );
  }

  void addCategory() {
    final name = categoryController.text.trim();

    if (name.isEmpty) {
      Get.snackbar(
        "Warning",
        "Please enter a category name.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final category = CategoryModel(
      name: name,
      icon: "assets/icons/category.png",
    );

    categories.add(category);

    categoryController.clear();

    Get.back();

    Get.snackbar(
      "Success",
      "Category added successfully.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deleteCategory(int index) {
    final category = categories[index];

    Get.defaultDialog(
      title: "Delete Category",
      middleText:
      "Are you sure you want to delete ${category.name}?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      onConfirm: () {
        categories.removeAt(index);

        Get.back();

        Get.snackbar(
          "Deleted",
          "${category.name} deleted successfully.",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showAddCategoryDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Add Category"),
        content: TextField(
          controller: categoryController,
          decoration: const InputDecoration(
            hintText: "Category name",
            prefixIcon: Icon(Icons.category),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              categoryController.clear();
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: addCategory,
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    categoryController.dispose();
    super.onClose();
  }
}