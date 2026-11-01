import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/models/booking_model.dart';
import '../../app/data/models/review_model.dart';
import '../../app/data/models/worker_model.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';
import '../../app/widgets/review_card.dart';

class WorkerDashboardController extends GetxController {
  final currentIndex = 0.obs;

  Rxn<WorkerModel> get currentWorker => AppRepository.to.currentWorker;

  List<BookingModel> get workerBookings {
    final repo = AppRepository.to;
    final worker = repo.currentWorker.value;
    if (worker == null) return repo.bookings;
    final matched = repo.bookings
        .where(
          (b) =>
              b.workerId == worker.id ||
              b.workerName.toLowerCase() == worker.name.toLowerCase(),
        )
        .toList();
    return matched.isNotEmpty ? matched : repo.bookings;
  }

  List<ReviewModel> get workerReviews {
    final repo = AppRepository.to;
    final worker = repo.currentWorker.value;
    if (worker == null) return repo.reviews;
    return repo.getReviewsForWorker(worker.id, worker.name);
  }

  void changePage(int index) {
    currentIndex.value = index;

    switch (index) {
      case 0:
        break;
      case 1:
        Get.toNamed(AppRoutes.workerBooking)?.then((_) {
          currentIndex.value = 0;
        });
        break;
      case 2:
        Get.toNamed(AppRoutes.availability)?.then((_) {
          currentIndex.value = 0;
        });
        break;
    }
  }

  void openManageProfile() {
    final repo = AppRepository.to;
    final worker = repo.currentWorker.value ??
        (repo.workers.isNotEmpty ? repo.workers.first : null);
    if (worker == null) return;

    final nameCtrl = TextEditingController(text: worker.name);
    final phoneCtrl = TextEditingController(text: worker.phone);
    final expCtrl = TextEditingController(text: worker.experience);
    final priceCtrl = TextEditingController(text: worker.price.toInt().toString());
    final bioCtrl = TextEditingController(text: worker.bio);
    final customAreaCtrl =
        TextEditingController(text: worker.serviceAreas.join(', '));

    final selectedCats = <String>[...worker.serviceCategories].obs;
    final selectedAreas = <String>[...worker.serviceAreas].obs;

    final allCats = repo.categories.map((c) => c.name).toList();
    final allAreas = DummyData.defaultAreas;

    Get.dialog(
      AlertDialog(
        title: const Text('Manage Worker Profile'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: expCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Experience',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: priceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Charge (৳)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Service Categories:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Obx(
                  () => Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: allCats.map((cat) {
                      final isSelected = selectedCats.contains(cat);
                      return FilterChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (_) {
                          if (isSelected) {
                            if (selectedCats.length > 1) {
                              selectedCats.remove(cat);
                            }
                          } else {
                            selectedCats.add(cat);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Service Area(s) / Localities:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Obx(
                  () => Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: allAreas.map((area) {
                      final isSelected = selectedAreas.contains(area);
                      return FilterChip(
                        label: Text(area),
                        selected: isSelected,
                        onSelected: (_) {
                          if (isSelected) {
                            if (selectedAreas.length > 1) {
                              selectedAreas.remove(area);
                            }
                          } else {
                            selectedAreas.add(area);
                          }
                          customAreaCtrl.text = selectedAreas.join(', ');
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: customAreaCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Localities (comma separated)',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: bioCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Bio / Service Summary',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final areas = customAreaCtrl.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
              final finalAreas =
                  areas.isNotEmpty ? areas : selectedAreas.toList();

              final updated = worker.copyWith(
                name: nameCtrl.text.trim().isNotEmpty
                    ? nameCtrl.text.trim()
                    : worker.name,
                phone: phoneCtrl.text.trim().isNotEmpty
                    ? phoneCtrl.text.trim()
                    : worker.phone,
                experience: expCtrl.text.trim().isNotEmpty
                    ? expCtrl.text.trim()
                    : worker.experience,
                price: double.tryParse(priceCtrl.text.trim()) ?? worker.price,
                profession: selectedCats.first,
                serviceCategories: selectedCats.toList(),
                location: finalAreas.first,
                serviceAreas: finalAreas,
                bio: bioCtrl.text.trim(),
              );

              await repo.updateWorkerProfile(updated);
              Get.back();
              Get.snackbar(
                'Profile Updated',
                'Your service categories, areas, and profile details have been saved.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Save Profile'),
          ),
        ],
      ),
    );
  }

  void openMyReviews() {
    Get.dialog(
      AlertDialog(
        title: const Text('My Customer Reviews'),
        content: SizedBox(
          width: double.maxFinite,
          child: Obx(
            () {
              final list = workerReviews;
              if (list.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'No customer reviews yet.',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, index) => ReviewCard(review: list[index]),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    await AppRepository.to.logout();
    Get.offAllNamed(AppRoutes.chooseUser);
  }
}
