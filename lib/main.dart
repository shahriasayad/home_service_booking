import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/data/repositories/app_repository.dart';
import 'app/data/services/local_storage_service.dart';
import 'app/routes/app_page.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'app/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = LocalStorageService();
  await storage.init();
  Get.put<LocalStorageService>(storage, permanent: true);

  final repo = AppRepository(storage);
  repo.loadInitialData();
  Get.put<AppRepository>(repo, permanent: true);

  Get.put<ThemeController>(ThemeController(storage), permanent: true);

  runApp(const HomeServiceApp());
}

class HomeServiceApp extends StatelessWidget {
  const HomeServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = Get.isRegistered<ThemeController>()
        ? ThemeController.to.themeMode.value
        : ThemeMode.system;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Service Booking',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
    );
  }
}
