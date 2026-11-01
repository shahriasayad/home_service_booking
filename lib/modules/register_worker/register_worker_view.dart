import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/utils/validators.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';
import 'register_worker_controller.dart';

class RegisterWorkerView extends GetView<RegisterWorkerController> {
  const RegisterWorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Worker Registration',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Worker Account',
                  style: AppTextStyles.heading,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: controller.nameController,
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                  prefixIcon: Icons.person,
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: controller.phoneController,
                  hintText: 'Phone Number (11 digits)',
                  labelText: 'Phone Number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select Service Categories',
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: controller.availableCategories.map((cat) {
                      final isSelected =
                          controller.selectedCategories.contains(cat);
                      return FilterChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (_) => controller.toggleCategory(cat),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: controller.professionController,
                  hintText: 'Primary Profession',
                  labelText: 'Primary Service Category',
                  prefixIcon: Icons.work,
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.experienceController,
                        hintText: 'Experience (e.g. 5)',
                        labelText: 'Experience (Years)',
                        prefixIcon: Icons.workspace_premium,
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                            (val == null || val.trim().isEmpty)
                                ? 'Enter experience'
                                : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.priceController,
                        hintText: 'Charge (৳)',
                        labelText: 'Service Charge (৳)',
                        prefixIcon: Icons.payments_outlined,
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                            (val == null || val.trim().isEmpty)
                                ? 'Enter charge'
                                : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select Service Area(s) / Localities',
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: controller.availableAreas.map((area) {
                      final isSelected = controller.selectedAreas.contains(area);
                      return FilterChip(
                        label: Text(area),
                        selected: isSelected,
                        onSelected: (_) => controller.toggleArea(area),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: controller.addressController,
                  hintText: 'Service Area(s) (comma separated, e.g. Mymensingh)',
                  labelText: 'Service Area(s) / Locality',
                  prefixIcon: Icons.location_on,
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 14),
                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    obscureText: controller.hidePassword.value,
                    validator: Validators.validatePassword,
                    suffixIcon: IconButton(
                      onPressed: controller.togglePassword,
                      icon: Icon(
                        controller.hidePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Obx(
                  () => CustomTextField(
                    controller: controller.confirmPasswordController,
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.hideConfirmPassword.value,
                    validator: (value) {
                      return Validators.validateConfirmPassword(
                        controller.passwordController.text,
                        value,
                      );
                    },
                    suffixIcon: IconButton(
                      onPressed: controller.toggleConfirmPassword,
                      icon: Icon(
                        controller.hideConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Obx(
                  () => CustomButton(
                    text: 'Register as Worker',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.register,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
