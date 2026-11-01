import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';

class RegisterWorkerController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController professionController =
      TextEditingController(text: 'Electrician');
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController priceController =
      TextEditingController(text: '500');
  final TextEditingController addressController =
      TextEditingController(text: 'Mymensingh');
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxList<String> selectedCategories = <String>['Electrician'].obs;
  final RxList<String> selectedAreas = <String>['Mymensingh'].obs;

  final RxBool hidePassword = true.obs;
  final RxBool hideConfirmPassword = true.obs;
  final RxBool isLoading = false.obs;

  List<String> get availableCategories =>
      AppRepository.to.categories.map((c) => c.name).toList();

  List<String> get availableAreas => DummyData.defaultAreas;

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      if (selectedCategories.length > 1) {
        selectedCategories.remove(category);
      }
    } else {
      selectedCategories.add(category);
    }
    professionController.text = selectedCategories.first;
  }

  void toggleArea(String area) {
    if (selectedAreas.contains(area)) {
      if (selectedAreas.length > 1) {
        selectedAreas.remove(area);
      }
    } else {
      selectedAreas.add(area);
    }
    addressController.text = selectedAreas.join(', ');
  }

  void togglePassword() {
    hidePassword.value = !hidePassword.value;
  }

  void toggleConfirmPassword() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));

    final parsedAreas = addressController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final areas = parsedAreas.isNotEmpty ? parsedAreas : selectedAreas.toList();

    final parsedCategories = selectedCategories.isNotEmpty
        ? selectedCategories.toList()
        : [professionController.text.trim()];

    await AppRepository.to.registerWorker(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      profession: parsedCategories.first,
      serviceCategories: parsedCategories,
      experience: experienceController.text,
      location: areas.first,
      serviceAreas: areas,
      price: double.tryParse(priceController.text.trim()) ?? 500.0,
      password: passwordController.text,
    );

    isLoading.value = false;

    Get.offAllNamed(AppRoutes.workerDashboard);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    professionController.dispose();
    experienceController.dispose();
    priceController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
