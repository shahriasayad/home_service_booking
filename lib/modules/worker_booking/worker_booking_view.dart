import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';

import 'worker_booking_controller.dart';

class WorkerBookingView extends GetView<WorkerBookingController> {
  const WorkerBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Bookings",
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Obx(
              () => ListView.builder(
            itemCount: controller.bookings.length,
            itemBuilder: (_, index) {

              final booking =
              controller.bookings[index];

              return Card(
                margin:
                const EdgeInsets.only(bottom: 15),

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      ListTile(

                        contentPadding:
                        EdgeInsets.zero,

                        leading: CircleAvatar(
                          backgroundImage:
                          AssetImage(
                            booking.image,
                          ),
                        ),

                        title: Text(
                          booking.workerName,
                        ),

                        subtitle: Text(
                          booking.profession,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Date : ${booking.date}",
                      ),

                      Text(
                        "Time : ${booking.time}",
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Status : ${booking.status}",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: booking.status ==
                              "Accepted"
                              ? Colors.green
                              : booking.status ==
                              "Rejected"
                              ? Colors.red
                              : Colors.orange,
                        ),
                      ),

                      const SizedBox(height: 15),

                      if (booking.status ==
                          "Pending")

                        Row(
                          children: [

                            Expanded(
                              child:
                              ElevatedButton(
                                onPressed: () {
                                  controller
                                      .acceptBooking(
                                      index);
                                },
                                child: const Text(
                                  "Accept",
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child:
                              ElevatedButton(
                                onPressed: () {
                                  controller
                                      .rejectBooking(
                                      index);
                                },
                                style:
                                ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                  Colors.red,
                                ),
                                child: const Text(
                                  "Reject",
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}