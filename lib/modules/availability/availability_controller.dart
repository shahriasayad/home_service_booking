import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/repositories/app_repository.dart';

class AvailabilityController extends GetxController {
  final isAvailable = true.obs;

  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  final selectedDays = <String>[].obs;

  final days = const [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  @override
  void onInit() {
    super.onInit();

    final worker = AppRepository.to.currentWorker.value;
    if (worker != null) {
      isAvailable.value = worker.isAvailable;
      selectedDays.assignAll(worker.workingDays);
      startTimeController.text = worker.startTime;
      endTimeController.text = worker.endTime;
    } else {
      selectedDays.assignAll([
        'Saturday',
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
      ]);
      startTimeController.text = '09:00 AM';
      endTimeController.text = '06:00 PM';
    }
  }

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
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (picked != null) {
      startTimeController.text = _formatTimeOfDay(picked);
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 0),
    );

    if (picked != null) {
      endTimeController.text = _formatTimeOfDay(picked);
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> saveAvailability() async {
    final repo = AppRepository.to;
    final worker = repo.currentWorker.value;
    if (worker != null) {
      final updated = worker.copyWith(
        isAvailable: isAvailable.value,
        workingDays: selectedDays.toList(),
        startTime: startTimeController.text.trim().isNotEmpty
            ? startTimeController.text.trim()
            : '09:00 AM',
        endTime: endTimeController.text.trim().isNotEmpty
            ? endTimeController.text.trim()
            : '06:00 PM',
      );
      await repo.updateWorkerProfile(updated);
    }

    Get.snackbar(
      'Success',
      'Availability schedule saved and updated.',
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
