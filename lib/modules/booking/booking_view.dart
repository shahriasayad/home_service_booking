import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';
import '../../app/utils/validators.dart';

import 'booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final worker = controller.worker;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Book Service",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [

              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    AssetImage(worker.image),
                  ),
                  title: Text(worker.name),
                  subtitle: Text(worker.profession),
                ),
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: controller.addressController,
                hintText: "Service Address",
                prefixIcon: Icons.location_on,
                maxLines: 2,
                validator: Validators.validateName,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: controller.dateController,
                hintText: "Select Date",
                readOnly: true,
                prefixIcon: Icons.calendar_today,
                onTap: () =>
                    controller.selectDate(context),
                validator: Validators.validateName,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: controller.timeController,
                hintText: "Select Time",
                readOnly: true,
                prefixIcon: Icons.access_time,
                onTap: () =>
                    controller.selectTime(context),
                validator: Validators.validateName,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                controller: controller.noteController,
                hintText: "Additional Note",
                prefixIcon: Icons.note,
                maxLines: 4,
              ),

              const SizedBox(height: 30),

              Obx(
                    () => CustomButton(
                  text: "Continue to Payment",
                  isLoading:
                  controller.isLoading.value,
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