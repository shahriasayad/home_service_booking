import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/utils/validators.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Login',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Welcome Back',
                  style: AppTextStyles.heading,
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Text(
                    'Login as ${controller.role.value}',
                    style: AppTextStyles.body,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    children: ['Customer', 'Worker', 'Admin'].map((r) {
                      final isSelected = controller.role.value == r;
                      return ChoiceChip(
                        label: Text(r),
                        selected: isSelected,
                        onSelected: (_) => controller.setRole(r),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  labelText: 'Email Address',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 18),
                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    obscureText: controller.isPasswordHidden.value,
                    validator: Validators.validatePassword,
                    suffixIcon: IconButton(
                      onPressed: controller.togglePassword,
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Obx(
                  () => CustomButton(
                    text: 'Login',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.login,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => controller.role.value == 'Admin'
                      ? const SizedBox.shrink()
                      : Center(
                          child: TextButton(
                            onPressed: controller.goToRegister,
                            child: Text(
                              "Don't have a ${controller.role.value} account? Register",
                            ),
                          ),
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
