import 'package:get/get.dart';

import '../../app/data/models/category_model.dart';
import '../../app/data/models/worker_model.dart';
import '../../app/data/repositories/app_repository.dart';

class CategoryController extends GetxController {
  final categories = <CategoryModel>[].obs;
  final workers = <WorkerModel>[].obs;

  final selectedCategory = ''.obs;
  final selectedArea = 'All Areas'.obs;

  List<String> get areaOptions => ['All Areas', ...AppRepository.to.availableAreas];

  @override
  void onInit() {
    super.onInit();

    final repo = AppRepository.to;
    categories.assignAll(repo.categories);

    if (Get.arguments is String && (Get.arguments as String).isNotEmpty) {
      selectedCategory.value = Get.arguments as String;
    }

    _applyFilter();

    ever<List<CategoryModel>>(repo.categories, (list) {
      categories.assignAll(list);
    });
    ever<List<WorkerModel>>(repo.workers, (_) {
      _applyFilter();
    });
  }

  void filterWorkers(String category) {
    if (selectedCategory.value.toLowerCase() == category.toLowerCase()) {
      selectedCategory.value = '';
    } else {
      selectedCategory.value = category;
    }
    _applyFilter();
  }

  void selectArea(String area) {
    selectedArea.value = area;
    _applyFilter();
  }

  void _applyFilter() {
    final cat = selectedCategory.value;
    final area = selectedArea.value;

    workers.assignAll(
      AppRepository.to.workers.where((worker) {
        if (worker.approvalStatus != 'Approved') return false;
        final matchesCat = worker.matchesCategory(cat);
        final matchesLocality = worker.matchesArea(area);
        return matchesCat && matchesLocality;
      }),
    );
  }
}
