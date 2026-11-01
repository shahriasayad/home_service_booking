import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/models/booking_model.dart';

class BookingHistoryController extends GetxController {

  final bookings = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    bookings.assignAll(
      DummyData.bookingHistory,
    );
  }
}