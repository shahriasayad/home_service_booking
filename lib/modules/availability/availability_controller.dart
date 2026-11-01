import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailabilityController extends GetxController {
  final isAvailable = true.obs;

  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  final selectedDays = <String>[].obs;

  final days = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];

  void toggleAvailability(bool value) {
    isAvailable.value = value;
  }

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  Future<void> pickStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      startTimeController.text = picked.format(context);
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      endTimeController.text = picked.format(context);
    }
  }

  void saveAvailability() {
    Get.snackbar(
      "Success",
      "Availability Updated Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    startTimeController.dispose();
    endTimeController.dispose();
    super.onClose();
  }
}