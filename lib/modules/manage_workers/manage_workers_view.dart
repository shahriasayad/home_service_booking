import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';

import 'manage_workers_controller.dart';

class ManageWorkersView
    extends GetView<ManageWorkersController> {
  const ManageWorkersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Manage Workers",
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            TextField(
              onChanged: controller.searchWorker,
              decoration: InputDecoration(
                hintText: "Search worker...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Obx(
                    () {
                  if (controller.filteredWorkers.isEmpty) {
                    return const Center(
                      child: Text(
                        "No workers found.",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount:
                    controller.filteredWorkers.length,
                    itemBuilder: (_, index) {
                      final worker =
                      controller.filteredWorkers[index];

                      return Card(
                        margin:
                        const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding:
                          const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding:
                                EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundImage:
                                  AssetImage(
                                    worker.image,
                                  ),
                                ),
                                title: Text(
                                  worker.name,
                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  worker.profession,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller
                                            .approveWorker(
                                          index,
                                        );
                                      },
                                      child:
                                      const Text(
                                        "Approve",
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller
                                            .rejectWorker(
                                          index,
                                        );
                                      },
                                      style:
                                      ElevatedButton
                                          .styleFrom(
                                        backgroundColor:
                                        Colors.orange,
                                      ),
                                      child:
                                      const Text(
                                        "Reject",
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  IconButton(
                                    onPressed: () {
                                      controller
                                          .deleteWorker(
                                        index,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}