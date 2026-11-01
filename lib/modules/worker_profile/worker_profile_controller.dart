import 'package:get/get.dart';

import '../../app/data/models/worker_model.dart';
import '../../app/routes/app_routes.dart';

class WorkerProfileController extends GetxController {
  late WorkerModel worker;

  @override
  void onInit() {
    super.onInit();

    worker = Get.arguments as WorkerModel;
  }

  void bookNow() {
    Get.toNamed(
      AppRoutes.booking,
      arguments: worker,
    );
  }
}