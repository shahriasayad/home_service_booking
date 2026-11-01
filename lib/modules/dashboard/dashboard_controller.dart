import 'package:get/get.dart';

import '../booking_history/booking_history_view.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';

class DashboardController extends GetxController {

  final currentIndex = 0.obs;

  final pages = const [
    HomeView(),
    BookingHistoryView(),
    ProfileView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}