import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/models/user_model.dart';
import '../../app/data/repositories/app_repository.dart';
import '../../app/routes/app_routes.dart';
import '../../app/theme/theme_controller.dart';

class ProfileController extends GetxController {
  final name = 'Nusrat Orpi'.obs;
  final email = 'orpi@gmail.com'.obs;
  final phone = '01712345678'.obs;
  final area = 'Mymensingh'.obs;
  final address = 'Charpara, Mymensingh'.obs;

  @override
  void onInit() {
    super.onInit();
    _syncFromRepo();
    ever<UserModel?>(AppRepository.to.currentUser, (_) => _syncFromRepo());
  }

  void _syncFromRepo() {
    final user = AppRepository.to.currentUser.value;
    if (user != null) {
      name.value = user.name;
      email.value = user.email;
      phone.value = user.phone;
      area.value = user.area;
      address.value = user.address;
    }
  }

  void editProfile() {
    final nameCtrl = TextEditingController(text: name.value);
    final phoneCtrl = TextEditingController(text: phone.value);
    final areaCtrl = TextEditingController(text: area.value);
    final addressCtrl = TextEditingController(text: address.value);

    Get.dialog(
      AlertDialog(
        title: const Text('Edit Customer Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: areaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Area / Locality',
                  prefixIcon: Icon(Icons.map_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty || areaCtrl.text.trim().isEmpty) {
                Get.snackbar(
                  'Validation Error',
                  'Name and Area/Locality cannot be empty.',
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }
              final repo = AppRepository.to;
              final current = repo.currentUser.value;
              final updated = (current ??
                      UserModel(
                        id: 1,
                        name: name.value,
                        email: email.value,
                        phone: phone.value,
                        address: address.value,
                      ))
                  .copyWith(
                name: nameCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
                area: areaCtrl.text.trim(),
                address: addressCtrl.text.trim(),
              );
              await repo.updateCustomerProfile(updated);
              Get.back();
              Get.snackbar(
                'Profile Updated',
                'Your profile and locality preferences have been saved.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void openThemeSettings() {
    if (Get.isRegistered<ThemeController>()) {
      ThemeController.to.showThemeDialog();
    }
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textCancel: 'Cancel',
      textConfirm: 'Logout',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await AppRepository.to.logout();
        Get.offAllNamed(AppRoutes.chooseUser);
      },
    );
  }
}
