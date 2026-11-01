import 'package:get/get.dart';

import '../../app/data/models/review_model.dart';
import '../../app/data/models/worker_model.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';

class WorkerProfileController extends GetxController {
  late final Rx<WorkerModel> workerRx;
  final RxList<ReviewModel> workerReviews = <ReviewModel>[].obs;

  WorkerModel get worker => workerRx.value;

  @override
  void onInit() {
    super.onInit();

    final repo = AppRepository.to;
    final arg = Get.arguments;
    final initialWorker = arg is WorkerModel
        ? arg
        : (repo.workers.isNotEmpty
            ? repo.workers.first
            : WorkerModel(
                id: 1,
                name: 'Rakib Hasan',
                profession: 'Electrician',
                experience: '5 Years',
                rating: 4.8,
                price: 600,
                image: 'assets/images/worker1.png',
                phone: '01711111111',
                location: 'Mymensingh',
              ));

    workerRx = initialWorker.obs;
    _refreshFromRepo();

    ever<List<WorkerModel>>(repo.workers, (_) => _refreshFromRepo());
    ever<List<ReviewModel>>(repo.reviews, (_) => _refreshFromRepo());
  }

  void _refreshFromRepo() {
    final repo = AppRepository.to;
    final latest = repo.workers.firstWhereOrNull((w) => w.id == workerRx.value.id);
    if (latest != null) {
      workerRx.value = latest;
    }
    workerReviews.assignAll(
      repo.getReviewsForWorker(workerRx.value.id, workerRx.value.name),
    );
  }

  void bookNow() {
    if (!workerRx.value.isAvailable) {
      Get.snackbar(
        'Worker Busy',
        '${workerRx.value.name} is currently marked unavailable, but you may schedule a future booking.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    Get.toNamed(
      AppRoutes.booking,
      arguments: workerRx.value,
    );
  }

  void writeReview() {
    Get.toNamed(
      AppRoutes.review,
      arguments: {
        'worker': workerRx.value,
      },
    );
  }
}
