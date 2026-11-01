import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/utils/validators.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfield.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Login"),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(AppSizes.md),

          child: Form(

            key: controller.formKey,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 30),

                Text(
                  "Welcome Back",
                  style: AppTextStyles.heading,
                ),

                const SizedBox(height: 10),

                Text(
                  "Login as ${controller.role}",
                  style: AppTextStyles.body,
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  controller: controller.emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 20),

                Obx(
                      () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    obscureText:
                    controller.isPasswordHidden.value,
                    validator: Validators.validatePassword,
                    suffixIcon: IconButton(
                      onPressed:
                      controller.togglePassword,
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Obx(
                      () => CustomButton(
                    text: "Login",
                    isLoading:
                    controller.isLoading.value,
                    onPressed: controller.login,
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: controller.goToRegister,
                    child: const Text(
                      "Don't have an account? Register",
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