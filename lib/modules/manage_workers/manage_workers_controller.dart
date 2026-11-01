import 'package:get/get.dart';

import '../../app/data/models/worker_model.dart';
import '../../app/data/repositories/app_repository.dart';

class ManageWorkersController extends GetxController {
  final workers = <WorkerModel>[].obs;
  final searchText = ''.obs;
  final filteredWorkers = <WorkerModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    final repo = AppRepository.to;
    workers.assignAll(repo.workers);
    filteredWorkers.assignAll(workers);

    ever<List<WorkerModel>>(repo.workers, (list) {
      workers.assignAll(list);
      searchWorker(searchText.value);
    });
  }

  void searchWorker(String value) {
    searchText.value = value;

    if (value.trim().isEmpty) {
      filteredWorkers.assignAll(workers);
      return;
    }

    final query = value.trim().toLowerCase();
    final result = workers
        .where(
          (worker) =>
              worker.name.toLowerCase().contains(query) ||
              worker.profession.toLowerCase().contains(query) ||
              worker.location.toLowerCase().contains(query) ||
              worker.serviceAreas.any((a) => a.toLowerCase().contains(query)),
        )
        .toList();

    filteredWorkers.assignAll(result);
  }

  Future<void> approveWorker(int index) async {
    if (index < 0 || index >= filteredWorkers.length) return;
    final worker = filteredWorkers[index];
    await AppRepository.to.updateWorkerApproval(worker.id, 'Approved');
    Get.snackbar(
      'Approved',
      '${worker.name} has been approved and is visible to customers.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> rejectWorker(int index) async {
    if (index < 0 || index >= filteredWorkers.length) return;
    final worker = filteredWorkers[index];
    await AppRepository.to.updateWorkerApproval(worker.id, 'Rejected');
    Get.snackbar(
      'Rejected',
      '${worker.name} has been marked as Rejected.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> deleteWorker(int index) async {
    if (index < 0 || index >= filteredWorkers.length) return;
    final worker = filteredWorkers[index];
    await AppRepository.to.deleteWorkerById(worker.id);
    Get.snackbar(
      'Deleted',
      '${worker.name} has been removed.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
