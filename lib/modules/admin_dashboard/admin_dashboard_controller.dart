import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/models/booking_model.dart';
import '../../app/data/models/payment_model.dart';
import '../../app/data/models/review_model.dart';
import '../../app/data/models/user_model.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/widgets/review_card.dart';

class AdminDashboardController extends GetxController {
  int get totalWorkers => AppRepository.to.workers.length;
  int get totalCustomers => AppRepository.to.users.length;
  int get totalBookings => AppRepository.to.bookings.length;
  int get totalCategories => AppRepository.to.categories.length;
  int get totalReviews => AppRepository.to.reviews.length;

  RxList<UserModel> get users => AppRepository.to.users;
  RxList<BookingModel> get bookings => AppRepository.to.bookings;
  RxList<ReviewModel> get reviews => AppRepository.to.reviews;
  RxList<PaymentRecordModel> get payments => AppRepository.to.payments;

  void goToManageWorkers() {
    Get.toNamed(AppRoutes.manageWorkers);
  }

  void goToManageCategories() {
    Get.toNamed(AppRoutes.manageCategories);
  }

  void openManageUsersSheet() {
    Get.dialog(
      AlertDialog(
        title: const Text('Manage Users'),
        content: SizedBox(
          width: double.maxFinite,
          child: Obx(() {
            if (users.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No registered users found.',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              itemCount: users.length,
              separatorBuilder: (_, _) => const Divider(height: 12),
              itemBuilder: (_, index) {
                final user = users[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${user.email} • ${user.area}\nStatus: ${user.isActive ? "Active" : "Suspended"}',
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: user.isActive
                            ? 'Suspend User'
                            : 'Activate User',
                        icon: Icon(
                          user.isActive ? Icons.block : Icons.check_circle,
                          color: user.isActive
                              ? AppColors.warning
                              : AppColors.success,
                        ),
                        onPressed: () async {
                          await AppRepository.to.toggleUserActiveStatus(
                            user.id,
                          );
                        },
                      ),
                      IconButton(
                        tooltip: 'Delete User',
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                        ),
                        onPressed: () async {
                          await AppRepository.to.deleteUserById(user.id);
                          Get.snackbar(
                            'User Removed',
                            '${user.name} has been removed.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  void openMonitorActivitySheet() {
    Get.dialog(
      DefaultTabController(
        length: 3,
        child: AlertDialog(
          title: const Text('System Activity & Reviews'),
          content: SizedBox(
            width: double.maxFinite,
            height: 420,
            child: Column(
              children: [
                const TabBar(
                  labelColor: AppColors.primary,
                  tabs: [
                    Tab(text: 'Reviews'),
                    Tab(text: 'Bookings'),
                    Tab(text: 'Payments'),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Reviews Tab
                      Obx(() {
                        if (reviews.isEmpty) {
                          return const Center(child: Text('No reviews yet.'));
                        }
                        return ListView.separated(
                          itemCount: reviews.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 8),
                          itemBuilder: (_, index) {
                            final rev = reviews[index];
                            return ReviewCard(
                              review: rev,
                              onDelete: () async {
                                await AppRepository.to.deleteReview(rev.id);
                                Get.snackbar(
                                  'Review Removed',
                                  'Review by ${rev.userName} removed.',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                            );
                          },
                        );
                      }),
                      // Bookings Tab
                      Obx(() {
                        if (bookings.isEmpty) {
                          return const Center(child: Text('No bookings yet.'));
                        }
                        return ListView.separated(
                          itemCount: bookings.length,
                          separatorBuilder: (_, _) => const Divider(height: 10),
                          itemBuilder: (_, index) {
                            final b = bookings[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                '${b.customerName} → ${b.workerName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                '${b.profession} • ${b.area}\n${b.date} at ${b.time} • ${b.status}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: Text(
                                '৳${b.amount.toInt()}\n${b.paymentStatus}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                      // Payments Tab
                      Obx(() {
                        if (payments.isEmpty) {
                          return const Center(
                            child: Text('No payments recorded.'),
                          );
                        }
                        return ListView.separated(
                          itemCount: payments.length,
                          separatorBuilder: (_, _) => const Divider(height: 10),
                          itemBuilder: (_, index) {
                            final p = payments[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.receipt_long,
                                color: AppColors.primary,
                              ),
                              title: Text(
                                '${p.method} • ৳${p.amount.toInt()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                'Ref: ${p.transactionRef}\n${p.timestamp} (Simulated)',
                                style: const TextStyle(fontSize: 11.5),
                              ),
                              trailing: Text(
                                p.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: p.status == 'Paid'
                                      ? AppColors.success
                                      : p.status == 'Failed'
                                      ? AppColors.error
                                      : AppColors.warning,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('Close')),
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    await AppRepository.to.logout();
    Get.offAllNamed(AppRoutes.chooseUser);
  }
}
