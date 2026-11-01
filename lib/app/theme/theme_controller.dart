import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/services/local_storage_service.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find<ThemeController>();

  static const String _themeKey = 'theme_mode';

  final LocalStorageService _storage;
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  ThemeController(this._storage);

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final saved = _storage.getSetting<String>(_themeKey, defaultValue: 'system');
    themeMode.value = _parseThemeMode(saved);
  }

  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  String get currentThemeLabel {
    switch (themeMode.value) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    await _storage.setSetting(_themeKey, _themeModeToString(mode));
  }

  void showThemeDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Appearance / Theme'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption(
                title: 'System Default',
                subtitle: 'Follow device light/dark setting',
                icon: Icons.brightness_auto,
                mode: ThemeMode.system,
              ),
              _buildOption(
                title: 'Light Theme',
                subtitle: 'Always use light appearance',
                icon: Icons.light_mode,
                mode: ThemeMode.light,
              ),
              _buildOption(
                title: 'Dark Theme',
                subtitle: 'Always use dark appearance',
                icon: Icons.dark_mode,
                mode: ThemeMode.dark,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode mode,
  }) {
    final isSelected = themeMode.value == mode;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: isSelected ? Get.theme.colorScheme.primary : null,
      ),
      onTap: () {
        setThemeMode(mode);
        Get.back();
      },
    );
  }
}
