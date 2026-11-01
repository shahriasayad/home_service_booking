import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/utils/validators.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';

import 'register_worker_controller.dart';

class RegisterWorkerView extends GetView<RegisterWorkerController> {
  const RegisterWorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Registration"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Create Worker Account",
                  style: AppTextStyles.heading,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: controller.nameController,
                  hintText: "Full Name",
                  prefixIcon: Icons.person,
                  validator: Validators.validateName,
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  controller: controller.emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  controller: controller.phoneController,
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  controller: controller.professionController,
                  hintText: "Profession",
                  prefixIcon: Icons.work,
                  validator: Validators.validateName,
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  controller: controller.experienceController,
                  hintText: "Experience (Years)",
                  prefixIcon: Icons.star,
                  keyboardType: TextInputType.number,
                  validator: Validators.validateName,
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  controller: controller.addressController,
                  hintText: "Address",
                  prefixIcon: Icons.location_on,
                  maxLines: 2,
                  validator: Validators.validateName,
                ),

                const SizedBox(height: 15),

                Obx(
                      () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: "Password",
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

                const SizedBox(height: 15),

                Obx(
                      () => CustomTextField(
                    controller:
                    controller.confirmPasswordController,
                    hintText: "Confirm Password",
                    prefixIcon: Icons.lock_outline,
                    obscureText:
                    controller.hideConfirmPassword.value,
                    validator: (value) {
                      return Validators.validateConfirmPassword(
                        controller.passwordController.text,
                        value,
                      );
                    },
                    suffixIcon: IconButton(
                      onPressed:
                      controller.toggleConfirmPassword,
                      icon: Icon(
                        controller.hideConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Obx(
                      () => CustomButton(
                    text: "Register",
                    isLoading:
                    controller.isLoading.value,
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