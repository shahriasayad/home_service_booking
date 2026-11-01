import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/models/worker_model.dart';
import '../../app/routes/app_routes.dart';

class BookingController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late WorkerModel worker;

  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final noteController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    worker = Get.arguments as WorkerModel;
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      dateController.text =
      "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }

  Future<void> bookNow() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    await Future.delayed(
      const Duration(seconds: 2),
    );

    isLoading.value = false;

    Get.toNamed(
      AppRoutes.payment,
      arguments: worker,
    );
  }

  @override
  void onClose() {
    addressController.dispose();
    dateController.dispose();
    timeController.dispose();
    noteController.dispose();

    super.onClose();
  }
}