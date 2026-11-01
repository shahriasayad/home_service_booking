import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/models/review_model.dart';
import '../theme/app_sizes.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              review.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            RatingBarIndicator(
              rating: review.rating.toDouble(),
              itemCount: 5,
              itemSize: 18,
              itemBuilder: (_, __) =>
              const Icon(Icons.star, color: Colors.amber),
            ),

            const SizedBox(height: 10),

            Text(review.review),
          ],
        ),
      ),
    );
  }
}