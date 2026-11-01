import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/utils/validators.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';
import 'booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final worker = controller.worker;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Book Service',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      worker.image,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                  title: Text(
                    worker.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${worker.profession} • ${worker.serviceAreas.join(', ')}',
                  ),
                  trailing: Text(
                    '৳${worker.price.toInt()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: controller.areaController,
                hintText: 'Area / Locality (e.g. Mymensingh)',
                labelText: 'Service Area / Locality',
                prefixIcon: Icons.map_outlined,
                validator: Validators.validateName,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: controller.addressController,
                hintText: 'House / Road / Detailed Service Address',
                labelText: 'Service Address',
                prefixIcon: Icons.location_on,
                maxLines: 2,
                validator: Validators.validateName,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: controller.dateController,
                hintText: 'Select Date',
                labelText: 'Preferred Date',
                readOnly: true,
                prefixIcon: Icons.calendar_today,
                onTap: () => controller.selectDate(context),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Please select date' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: controller.timeController,
                hintText: 'Select Time',
                labelText: 'Preferred Time',
                readOnly: true,
                prefixIcon: Icons.access_time,
                onTap: () => controller.selectTime(context),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Please select time' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: controller.noteController,
                hintText: 'Describe the issue or instructions (optional)',
                labelText: 'Additional Note',
                prefixIcon: Icons.note_alt_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 28),
              Obx(
                () => CustomButton(
                  text: 'Continue to Payment',
                  isLoading: controller.isLoading.value,
                  onPressed: controller.bookNow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
