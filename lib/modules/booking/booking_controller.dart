import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/models/booking_model.dart';
import '../../app/data/models/worker_model.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';
import '../../app/utils/date_formatter.dart';

class BookingController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late WorkerModel worker;

  final areaController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final noteController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    final repo = AppRepository.to;
    final arg = Get.arguments;
    worker = arg is WorkerModel
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

    final currentUser = repo.currentUser.value;
    areaController.text = currentUser?.area ?? worker.location;
    addressController.text = currentUser?.address ?? '';
    dateController.text = DateFormatter.formatDate(
      DateTime.now().add(const Duration(days: 1)),
    );
    timeController.text = '10:00 AM';
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      dateController.text = DateFormatter.formatDate(picked);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );

    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      timeController.text = '$hour:$minute $period';
    }
  }

  Future<void> bookNow() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400));

    final repo = AppRepository.to;
    final user = repo.currentUser.value;

    final draft = BookingModel(
      id: 'BK-${DateTime.now().millisecondsSinceEpoch}',
      workerId: worker.id,
      workerName: worker.name,
      profession: worker.profession,
      customerId: user?.id ?? 1,
      customerName: user?.name ?? 'Nusrat Orpi',
      customerPhone: user?.phone ?? '01712345678',
      address: addressController.text.trim(),
      area: areaController.text.trim(),
      date: dateController.text.trim(),
      time: timeController.text.trim(),
      note: noteController.text.trim(),
      status: 'Pending',
      image: worker.image,
      amount: worker.price,
    );

    repo.draftBooking.value = draft;
    isLoading.value = false;

    Get.toNamed(
      AppRoutes.payment,
      arguments: draft,
    );
  }

  @override
  void onClose() {
    areaController.dispose();
    addressController.dispose();
    dateController.dispose();
    timeController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
