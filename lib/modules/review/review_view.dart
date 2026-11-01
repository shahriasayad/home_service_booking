import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';
import 'review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Write Review',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate ${controller.workerName}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Your feedback helps maintain quality service in your locality.',
                style: TextStyle(color: AppColors.grey),
              ),
              const SizedBox(height: 20),
              Obx(
                () => RatingBar.builder(
                  initialRating: controller.rating.value,
                  minRating: 1,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemBuilder: (_, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: controller.updateRating,
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: controller.reviewController,
                hintText: 'Share your experience with this worker...',
                labelText: 'Your Review',
                maxLines: 5,
              ),
              const Spacer(),
              Obx(
                () => CustomButton(
                  text: 'Submit Review',
                  isLoading: controller.isSubmitting.value,
                  onPressed: controller.submitReview,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
