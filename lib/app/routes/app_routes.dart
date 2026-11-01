abstract class AppRoutes {
  AppRoutes._();

  // Splash
  static const splash = '/';

  // Onboarding
  static const onboarding = '/onboarding';

  // Choose User
  static const chooseUser = '/choose-user';

  // Authentication
  static const login = '/login';
  static const registerCustomer = '/register-customer';
  static const registerWorker = '/register-worker';

  // Customer
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const category = '/category';
  static const workerProfile = '/worker-profile';
  static const booking = '/booking';
  static const payment = '/payment';
  static const bookingSuccess = '/booking-success';
  static const bookingHistory = '/booking-history';
  static const review = '/review';
  static const profile = '/profile';

  // Worker
  static const workerDashboard = '/worker-dashboard';
  static const workerBooking = '/worker-booking';
  static const availability = '/availability';

  // Admin
  static const adminDashboard = '/admin-dashboard';
  static const manageWorkers = '/manage-workers';
  static const manageCategories = '/manage-categories';

}