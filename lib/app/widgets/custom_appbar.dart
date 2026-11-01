import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool showThemeToggle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.showBackButton = true,
    this.showThemeToggle = true,
  });

  @override
  Widget build(BuildContext context) {
    final combinedActions = <Widget>[
      if (showThemeToggle && Get.isRegistered<ThemeController>())
        IconButton(
          tooltip: 'Change Theme',
          icon: const Icon(Icons.brightness_6_outlined),
          onPressed: () => ThemeController.to.showThemeDialog(),
        ),
      ...?actions,
    ];

    return AppBar(
      centerTitle: centerTitle,
      elevation: 0,
      automaticallyImplyLeading: showBackButton,
      title: Text(title),
      actions: combinedActions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
