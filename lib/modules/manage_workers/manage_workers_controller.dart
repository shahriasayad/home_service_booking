import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/models/worker_model.dart';

class ManageWorkersController extends GetxController {
  final workers = <WorkerModel>[].obs;

  final searchText = ''.obs;

  final filteredWorkers = <WorkerModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    workers.assignAll(
      DummyData.workers,
    );

    filteredWorkers.assignAll(
      workers,
    );
  }

  void searchWorker(String value) {
    searchText.value = value;

    if (value.trim().isEmpty) {
      filteredWorkers.assignAll(workers);
      return;
    }

    final result = workers.where(
          (worker) =>
      worker.name.toLowerCase().contains(
        value.toLowerCase(),
      ) ||
          worker.profession.toLowerCase().contains(
            value.toLowerCase(),
          ),
    ).toList();

    filteredWorkers.assignAll(result);
  }

  void approveWorker(int index) {
    Get.snackbar(
      "Success",
      "${filteredWorkers[index].name} has been approved.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void rejectWorker(int index) {
    Get.snackbar(
      "Rejected",
      "${filteredWorkers[index].name} has been rejected.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deleteWorker(int index) {
    final worker = filteredWorkers[index];

    workers.remove(worker);
    filteredWorkers.remove(worker);

    Get.snackbar(
      "Deleted",
      "${worker.name} has been removed.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}