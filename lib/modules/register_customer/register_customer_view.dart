import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/utils/validators.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';
import 'register_customer_controller.dart';

class RegisterCustomerView extends GetView<RegisterCustomerController> {
  const RegisterCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Customer Registration',
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
                  'Create Customer Account',
                  style: AppTextStyles.heading,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: controller.nameController,
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                  prefixIcon: Icons.person,
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: controller.phoneController,
                  hintText: 'Phone Number (11 digits)',
                  labelText: 'Phone Number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: controller.areaController,
                  hintText: 'Area / Locality (e.g. Mymensingh)',
                  labelText: 'Area / Locality',
                  prefixIcon: Icons.map_outlined,
                  onChanged: (v) => controller.selectedArea.value = v.trim(),
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: controller.suggestedAreas.map((area) {
                      final isSelected = controller.selectedArea.value.toLowerCase() ==
                          area.toLowerCase();
                      return ActionChip(
                        label: Text(area),
                        backgroundColor: isSelected
                            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.15)
                            : null,
                        onPressed: () => controller.selectArea(area),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: controller.addressController,
                  hintText: 'Full Street Address',
                  labelText: 'Street Address',
                  prefixIcon: Icons.location_on,
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
                    text: 'Register',
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
