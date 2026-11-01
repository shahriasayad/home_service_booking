import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';
import 'availability_controller.dart';

class AvailabilityView extends GetView<AvailabilityController> {
  const AvailabilityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Availability',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Obx(
                () => SwitchListTile(
                  title: const Text(
                    'Available for Work',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    controller.isAvailable.value
                        ? 'Customers can book your services'
                        : 'Temporarily paused new requests',
                  ),
                  value: controller.isAvailable.value,
                  onChanged: controller.toggleAvailability,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Working Days',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.days.map((day) {
                  final selected = controller.selectedDays.contains(day);
                  return FilterChip(
                    label: Text(day),
                    selected: selected,
                    onSelected: (_) => controller.toggleDay(day),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: controller.startTimeController,
              hintText: 'Start Time',
              labelText: 'Start Time',
              readOnly: true,
              prefixIcon: Icons.access_time,
              onTap: () => controller.pickStartTime(context),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: controller.endTimeController,
              hintText: 'End Time',
              labelText: 'End Time',
              readOnly: true,
              prefixIcon: Icons.access_time_filled,
              onTap: () => controller.pickEndTime(context),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Save Availability',
              onPressed: controller.saveAvailability,
            ),
          ],
        ),
      ),
    );
  }
}
