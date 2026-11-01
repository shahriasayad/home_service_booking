import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  Widget buildItem(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Profile",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 55,
              backgroundImage:
              AssetImage("assets/images/profile.png"),
            ),

            const SizedBox(height: 20),

            Obx(() => Text(
              controller.name.value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )),

            const SizedBox(height: 30),

            Obx(() => buildItem(
              Icons.email,
              "Email",
              controller.email.value,
            )),

            Obx(() => buildItem(
              Icons.phone,
              "Phone",
              controller.phone.value,
            )),

            Obx(() => buildItem(
              Icons.location_on,
              "Address",
              controller.address.value,
            )),

            const SizedBox(height: 25),

            CustomButton(
              text: "Edit Profile",
              onPressed: controller.editProfile,
            ),

            const SizedBox(height: 15),

            CustomButton(
              text: "Logout",
              onPressed: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}