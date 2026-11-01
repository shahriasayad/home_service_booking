import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/models/category_model.dart';
import '../../app/data/models/worker_model.dart';
import '../../app/data/repositories/app_repository.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();

  final selectedIndex = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedArea = 'All Areas'.obs;

  final categories = <CategoryModel>[].obs;
  final workers = <WorkerModel>[].obs;

  List<String> get areaOptions => ['All Areas', ...AppRepository.to.availableAreas];

  @override
  void onInit() {
    super.onInit();

    final repo = AppRepository.to;
    categories.assignAll(repo.categories);

    // Default to user's area if available and has matching workers, otherwise All Areas
    final userArea = repo.currentUser.value?.area ?? '';
    if (userArea.isNotEmpty &&
        repo.workers.any((w) => w.approvalStatus == 'Approved' && w.matchesArea(userArea))) {
      selectedArea.value = userArea;
    }

    _applyFilters();

    ever<List<CategoryModel>>(repo.categories, (list) {
      categories.assignAll(list);
    });
    ever<List<WorkerModel>>(repo.workers, (_) {
      _applyFilters();
    });
  }

  void changeBottomNav(int index) {
    selectedIndex.value = index;
  }

  void selectArea(String area) {
    selectedArea.value = area;
    _applyFilters();
  }

  void searchWorker(String value) {
    searchQuery.value = value;
    _applyFilters();
  }

  void _applyFilters() {
    final query = searchQuery.value.trim().toLowerCase();
    final area = selectedArea.value;

    final filtered = AppRepository.to.workers.where((worker) {
      if (worker.approvalStatus != 'Approved') return false;

      final areaMatches = worker.matchesArea(area);
      if (!areaMatches) return false;

      if (query.isEmpty) return true;

      return worker.name.toLowerCase().contains(query) ||
          worker.profession.toLowerCase().contains(query) ||
          worker.serviceCategories.any((c) => c.toLowerCase().contains(query)) ||
          worker.location.toLowerCase().contains(query) ||
          worker.serviceAreas.any((a) => a.toLowerCase().contains(query));
    }).toList();

    workers.assignAll(filtered);
  }

  void showManualAreaDialog() {
    final areaInputController = TextEditingController(
      text: selectedArea.value == 'All Areas' ? '' : selectedArea.value,
    );
    Get.dialog(
      AlertDialog(
        title: const Text('Select or Enter Area / Locality'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: areaInputController,
              decoration: const InputDecoration(
                hintText: 'Enter locality (e.g. Mymensingh)',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Popular Localities:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: areaOptions.map((area) {
                return ActionChip(
                  label: Text(area),
                  onPressed: () {
                    selectArea(area);
                    Get.back();
                  },
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final entered = areaInputController.text.trim();
              selectArea(entered.isEmpty ? 'All Areas' : entered);
              Get.back();
            },
            child: const Text('Apply Area'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
