import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';

import 'worker_profile_controller.dart';

class WorkerProfileView extends GetView<WorkerProfileController> {
  const WorkerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final worker = controller.worker;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Worker Profile",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [

            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(worker.image),
            ),

            const SizedBox(height: 20),

            Text(
              worker.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              worker.profession,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            RatingBarIndicator(
              rating: worker.rating,
              itemCount: 5,
              itemSize: 24,
              itemBuilder: (_, __) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.work),
                title: const Text("Experience"),
                subtitle: Text(worker.experience),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text("Service Charge"),
                subtitle: Text("\$${worker.price}"),
              ),
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Book Now",
              onPressed: controller.bookNow,
            ),
          ],
        ),
      ),
    );
  }
}