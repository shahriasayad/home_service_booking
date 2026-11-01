import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/models/category_model.dart';
import '../../app/data/models/worker_model.dart';

class CategoryController extends GetxController {

  final categories = <CategoryModel>[].obs;
  final workers = <WorkerModel>[].obs;

  final selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();

    categories.assignAll(DummyData.categories);
    workers.assignAll(DummyData.workers);

    if (Get.arguments != null) {
      selectedCategory.value = Get.arguments;
      filterWorkers(selectedCategory.value);
    }
  }

  void filterWorkers(String category) {

    selectedCategory.value = category;

    workers.assignAll(
      DummyData.workers.where(
            (worker) =>
        worker.profession.toLowerCase() ==
            category.toLowerCase(),
      ),
    );
  }
}