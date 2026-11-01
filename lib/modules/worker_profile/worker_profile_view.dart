import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/review_card.dart';
import 'worker_profile_controller.dart';

class WorkerProfileView extends GetView<WorkerProfileController> {
  const WorkerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Worker Profile',
      ),
      body: Obx(
        () {
          final worker = controller.workerRx.value;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    worker.image,
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => CircleAvatar(
                      radius: 55,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                      child: const Icon(
                        Icons.person,
                        size: 54,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  worker.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: worker.serviceCategories.map((cat) {
                    return Chip(
                      label: Text(cat),
                      visualDensity: VisualDensity.compact,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBarIndicator(
                      rating: worker.rating,
                      itemCount: 5,
                      itemSize: 22,
                      itemBuilder: (_, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${worker.rating.toStringAsFixed(1)} (${controller.workerReviews.length} reviews)',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  worker.bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.grey),
                ),
                const SizedBox(height: 20),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.work, color: AppColors.primary),
                    title: const Text('Experience & Completed Jobs'),
                    subtitle: Text(
                      '${worker.experience} • ${worker.completedJobs} Jobs Completed',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    leading:
                        const Icon(Icons.attach_money, color: AppColors.primary),
                    title: const Text('Service Charge'),
                    subtitle: Text('৳${worker.price.toInt()} per visit'),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    leading:
                        const Icon(Icons.location_on, color: AppColors.primary),
                    title: const Text('Service Area(s) / Localities'),
                    subtitle: Text(worker.serviceAreas.join(', ')),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    leading:
                        const Icon(Icons.schedule, color: AppColors.primary),
                    title: Text(
                      worker.isAvailable
                          ? 'Available (${worker.startTime} - ${worker.endTime})'
                          : 'Currently Busy',
                    ),
                    subtitle: Text('Days: ${worker.workingDays.join(', ')}'),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone, color: AppColors.primary),
                    title: const Text('Contact Number'),
                    subtitle: Text(worker.phone),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Book Now',
                  icon: Icons.calendar_month,
                  onPressed: controller.bookNow,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Customer Reviews (${controller.workerReviews.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: controller.writeReview,
                      icon: const Icon(Icons.rate_review_outlined, size: 18),
                      label: const Text('Write Review'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (controller.workerReviews.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'No reviews yet. Be the first to review!',
                      style: TextStyle(color: AppColors.grey),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.workerReviews.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      return ReviewCard(
                        review: controller.workerReviews[index],
                      );
                    },
                  ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
