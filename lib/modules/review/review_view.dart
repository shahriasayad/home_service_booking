import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

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
        title: "Write Review",
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Rate this Worker",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Obx(
                  () => RatingBar.builder(
                initialRating: controller.rating.value,
                minRating: 1,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (_, __) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: controller.updateRating,
              ),
            ),

            const SizedBox(height: 30),

            CustomTextField(
              controller: controller.reviewController,
              hintText: "Write your review...",
              maxLines: 5,
            ),

            const Spacer(),

            CustomButton(
              text: "Submit Review",
              onPressed: controller.submitReview,
            ),
          ],
        ),
      ),
    );
  }
}