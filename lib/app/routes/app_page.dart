import 'package:get/get.dart';

import '../../modules/admin_dashboard/admin_dashboard_binding.dart';
import '../../modules/admin_dashboard/admin_dashboard_view.dart';
import '../../modules/availability/availability_binding.dart';
import '../../modules/availability/availability_view.dart';
import '../../modules/booking/booking_binding.dart';
import '../../modules/booking/booking_view.dart';
import '../../modules/booking_history/booking_history_binding.dart';
import '../../modules/booking_history/booking_history_view.dart';
import '../../modules/booking_success/booking_success_binding.dart';
import '../../modules/booking_success/booking_success_view.dart';
import '../../modules/category/category_binding.dart';
import '../../modules/category/category_view.dart';
import '../../modules/choose_user/choose_user_binding.dart';
import '../../modules/choose_user/choose_user_view.dart';
import '../../modules/dashboard/dashboard_binding.dart';
import '../../modules/dashboard/dashboard_view.dart';
import '../../modules/home/home_binding.dart';
import '../../modules/home/home_view.dart';
import '../../modules/login/login_binding.dart';
import '../../modules/login/login_view.dart';
import '../../modules/manage_categories/manage_categories_binding.dart';
import '../../modules/manage_categories/manage_categories_view.dart';
import '../../modules/manage_workers/manage_workers_binding.dart';
import '../../modules/manage_workers/manage_workers_view.dart';
import '../../modules/onboarding/onboarding_binding.dart';
import '../../modules/onboarding/onboarding_view.dart';
import '../../modules/payment/payment_binding.dart';
import '../../modules/payment/payment_view.dart';
import '../../modules/profile/profile_binding.dart';
import '../../modules/profile/profile_view.dart';
import '../../modules/register_customer/register_customer_binding.dart';
import '../../modules/register_customer/register_customer_view.dart';
import '../../modules/register_worker/register_worker_binding.dart';
import '../../modules/register_worker/register_worker_view.dart';
import '../../modules/review/review_binding.dart';
import '../../modules/review/review_view.dart';
import '../../modules/splash/splash_binding.dart';
import '../../modules/splash/splash_view.dart';
import '../../modules/worker_booking/worker_booking_binding.dart';
import '../../modules/worker_booking/worker_booking_view.dart';
import '../../modules/worker_dashboard/worker_dashboard_binding.dart';
import '../../modules/worker_dashboard/worker_dashboard_view.dart';
import '../../modules/worker_profile/worker_profile_binding.dart';
import '../../modules/worker_profile/worker_profile_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.chooseUser,
      page: () => const ChooseUserView(),
      binding: ChooseUserBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.registerCustomer,
      page: () => const RegisterCustomerView(),
      binding: RegisterCustomerBinding(),
    ),
    GetPage(
      name: AppRoutes.registerWorker,
      page: () => const RegisterWorkerView(),
      binding: RegisterWorkerBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.workerDashboard,
      page: () => const WorkerDashboardView(),
      binding: WorkerDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.workerProfile,
      page: () => const WorkerProfileView(),
      binding: WorkerProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.booking,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: AppRoutes.bookingSuccess,
      page: () => const BookingSuccessView(),
      binding: BookingSuccessBinding(),
    ),
    GetPage(
      name: AppRoutes.workerBooking,
      page: () => const WorkerBookingView(),
      binding: WorkerBookingBinding(),
    ),
    GetPage(
      name: AppRoutes.review,
      page: () => const ReviewView(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: AppRoutes.bookingHistory,
      page: () => const BookingHistoryView(),
      binding: BookingHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.availability,
      page: () => const AvailabilityView(),
      binding: AvailabilityBinding(),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.manageWorkers,
      page: () => const ManageWorkersView(),
      binding: ManageWorkersBinding(),
    ),
    GetPage(
      name: AppRoutes.manageCategories,
      page: () => const ManageCategoriesView(),
      binding: ManageCategoriesBinding(),
    ),
  ];
}
