import 'package:flutter/material.dart';

import '../data/models/booking_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onReviewTap;
  final VoidCallback? onCancelTap;

  const BookingCard({
    super.key,
    required this.booking,
    this.onReviewTap,
    this.onCancelTap,
  });

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppColors.success;
      case 'Accepted':
        return AppColors.primary;
      case 'Cancelled':
      case 'Rejected':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(booking.status);

    return Card(
      elevation: AppSizes.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    booking.image,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                      child: const Icon(Icons.person, color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.workerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        booking.profession,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 15, color: AppColors.grey),
                const SizedBox(width: 6),
                Text(
                  '${booking.date} • ${booking.time}',
                  style: const TextStyle(fontSize: 13),
                ),
                const Spacer(),
                Text(
                  '৳${booking.amount.toInt()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 15, color: AppColors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    booking.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: AppColors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.payments_outlined, size: 15, color: AppColors.grey),
                const SizedBox(width: 6),
                Text(
                  '${booking.paymentMethod} (${booking.paymentStatus})',
                  style: const TextStyle(fontSize: 12, color: AppColors.grey),
                ),
              ],
            ),
            if ((booking.status == 'Completed' &&
                    !booking.isReviewed &&
                    onReviewTap != null) ||
                (booking.status == 'Pending' && onCancelTap != null)) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (booking.status == 'Pending' && onCancelTap != null)
                    OutlinedButton.icon(
                      onPressed: onCancelTap,
                      icon: const Icon(Icons.cancel_outlined, size: 16),
                      label: const Text('Cancel Booking'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                      ),
                    ),
                  if (booking.status == 'Completed' &&
                      !booking.isReviewed &&
                      onReviewTap != null)
                    ElevatedButton.icon(
                      onPressed: onReviewTap,
                      icon: const Icon(Icons.star_rate_rounded, size: 18),
                      label: const Text('Rate & Review'),
                    ),
                ],
              ),
            ],
            if (booking.isReviewed) ...[
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.check_circle, size: 15, color: AppColors.success),
                  SizedBox(width: 4),
                  Text(
                    'Review submitted',
                    style: TextStyle(fontSize: 12, color: AppColors.success),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
