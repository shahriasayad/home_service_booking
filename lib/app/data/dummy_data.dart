import 'models/category_model.dart';
import 'models/worker_model.dart';
import 'models/booking_model.dart';
import 'models/review_model.dart';
import 'models/payment_model.dart';

class DummyData {
  DummyData._();

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 1,
      name: "Electrician",
      image: "assets/images/electrician.png",
    ),
    CategoryModel(
      id: 2,
      name: "Plumber",
      image: "assets/images/plumber.png",
    ),
    CategoryModel(
      id: 3,
      name: "Cleaner",
      image: "assets/images/cleaner.png",
    ),
    CategoryModel(
      id: 4,
      name: "Carpenter",
      image: "assets/images/carpenter.png",
    ),
    CategoryModel(
      id: 5,
      name: "Painter",
      image: "assets/images/painter.png",
    ),
    CategoryModel(
      id: 6,
      name: "AC Repair",
      image: "assets/images/ac.png",
    ),
  ];

  //======================
  // Workers
  //======================

  static List<WorkerModel> workers = [
    WorkerModel(
      id: 1,
      name: "Rakib Hasan",
      profession: "Electrician",
      experience: "5 Years",
      rating: 4.8,
      image: "assets/images/worker1.png",
      phone: "01711111111",
      location: "Mymensingh",
    ),
    WorkerModel(
      id: 2,
      name: "Nayeem Ahmed",
      profession: "Plumber",
      experience: "4 Years",
      rating: 4.7,
      image: "assets/images/worker2.png",
      phone: "01822222222",
      location: "Dhaka",
    ),
    WorkerModel(
      id: 3,
      name: "Sabbir Islam",
      profession: "Cleaner",
      experience: "6 Years",
      rating: 4.9,
      image: "assets/images/worker3.png",
      phone: "01933333333",
      location: "Gazipur",
    ),
  ];


  static List<BookingModel> bookingHistory = [

    BookingModel(
      workerName: "Rakib Hasan",
      profession: "Electrician",
      date: "12 Aug 2026",
      time: "10:00 AM",
      status: "Completed",
      image: "assets/images/worker1.jpg",
    ),

    BookingModel(
      workerName: "Jahid",
      profession: "Plumber",
      date: "15 Aug 2026",
      time: "2:30 PM",
      status: "Pending",
      image: "assets/images/worker2.jpg",
    ),

  ];

  static List<ReviewModel> reviews = [
    ReviewModel(
      userName: "Nusrat",
      rating: 5,
      review: "Very professional and polite.",
    ),
    ReviewModel(
      userName: "Rahim",
      rating: 4,
      review: "Service was good.",
    ),
  ];


  static List<PaymentModel> payments = [
    PaymentModel(
      title: "Cash on Service",
      icon: "assets/icons/payment.png",
    ),
    PaymentModel(
      title: "bKash",
      icon: "assets/icons/payment.png",
    ),
    PaymentModel(
      title: "Nagad",
      icon: "assets/icons/payment.png",
    ),
  ];
}