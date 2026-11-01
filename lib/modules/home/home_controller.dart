import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/models/category_model.dart';
import '../../app/data/models/worker_model.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();

  final selectedIndex = 0.obs;

  final categories = <CategoryModel>[].obs;
  final workers = <WorkerModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    categories.assignAll(DummyData.categories);
    workers.assignAll(DummyData.workers);
  }

  void changeBottomNav(int index) {
    selectedIndex.value = index;
  }

  void searchWorker(String value) {
    if (value.isEmpty) {
      workers.assignAll(DummyData.workers);
    } else {
      workers.assignAll(
        DummyData.workers.where(
              (worker) =>
          worker.name.toLowerCase().contains(value.toLowerCase()) ||
              worker.profession
                  .toLowerCase()
                  .contains(value.toLowerCase()),
        ),
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}