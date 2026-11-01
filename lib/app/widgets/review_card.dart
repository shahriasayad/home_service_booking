import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/models/review_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;
  final VoidCallback? onDelete;

  const ReviewCard({
    super.key,
    required this.review,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                  child: Text(
                    review.userName.isNotEmpty
                        ? review.userName[0].toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        review.date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                RatingBarIndicator(
                  rating: review.rating.toDouble(),
                  itemCount: 5,
                  itemSize: 16,
                  itemBuilder: (_, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.error),
                    onPressed: onDelete,
                    tooltip: 'Delete Review',
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(review.review),
          ],
        ),
      ),
    );
  }
}
