import 'package:get/get.dart';

import '../../app/data/dummy_data.dart';
import '../../app/data/models/booking_model.dart';

class WorkerBookingController extends GetxController {

  final bookings = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    bookings.assignAll(
      DummyData.bookingHistory,
    );
  }

  void acceptBooking(int index) {

    bookings[index] = BookingModel(
      workerName: bookings[index].workerName,
      profession: bookings[index].profession,
      date: bookings[index].date,
      time: bookings[index].time,
      status: "Accepted",
      image: bookings[index].image,
    );

    bookings.refresh();

    Get.snackbar(
      "Success",
      "Booking Accepted",
    );
  }

  void rejectBooking(int index) {

    bookings[index] = BookingModel(
      workerName: bookings[index].workerName,
      profession: bookings[index].profession,
      date: bookings[index].date,
      time: bookings[index].time,
      status: "Rejected",
      image: bookings[index].image,
    );

    bookings.refresh();

    Get.snackbar(
      "Rejected",
      "Booking Rejected",
    );
  }
}