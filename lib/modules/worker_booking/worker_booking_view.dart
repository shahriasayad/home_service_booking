import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import 'worker_booking_controller.dart';

class WorkerBookingView extends GetView<WorkerBookingController> {
  const WorkerBookingView({super.key});

  Color _statusColor(String status) {
    switch (status) {
      case 'Accepted':
        return AppColors.primary;
      case 'Completed':
        return AppColors.success;
      case 'Rejected':
      case 'Cancelled':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Booking Requests',
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Obx(
          () {
            if (controller.bookings.isEmpty) {
              return const Center(
                child: Text(
                  'No booking requests found.',
                  style: TextStyle(fontSize: 17),
                ),
              );
            }

            return ListView.builder(
              itemCount: controller.bookings.length,
              itemBuilder: (_, index) {
                final booking = controller.bookings[index];
                final statusColor = _statusColor(booking.status);

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
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
                                width: 46,
                                height: 46,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer: ${booking.customerName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Service: ${booking.profession} • ৳${booking.amount.toInt()}',
                                    style: const TextStyle(
                                      color: AppColors.primary,
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
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                booking.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 18),
                        Text('Date & Time: ${booking.date} at ${booking.time}'),
                        const SizedBox(height: 4),
                        Text('Locality / Address: ${booking.area} — ${booking.address}'),
                        const SizedBox(height: 4),
                        Text('Phone: ${booking.customerPhone}'),
                        const SizedBox(height: 4),
                        Text(
                          'Payment: ${booking.paymentMethod} (${booking.paymentStatus})',
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: AppColors.grey,
                          ),
                        ),
                        if (booking.note.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Note: ${booking.note}',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                        if (booking.status == 'Pending') ...[
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      controller.acceptBooking(index),
                                  icon: const Icon(Icons.check, size: 18),
                                  label: const Text('Accept'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      controller.rejectBooking(index),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.error,
                                  ),
                                  icon: const Icon(Icons.close, size: 18),
                                  label: const Text('Reject'),
                                ),
                              ),
                            ],
                          ),
                        ] else if (booking.status == 'Accepted') ...[
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  controller.completeBooking(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.success,
                              ),
                              icon: const Icon(Icons.task_alt, size: 18),
                              label: const Text('Mark Service Completed'),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
