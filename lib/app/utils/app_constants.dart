class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = "Home Service Booking";
  static const String appVersion = "1.0.0";

  // Animation Duration
  static const Duration animationDuration = Duration(milliseconds: 300);

  // API Timeout (Future Use)
  static const Duration apiTimeout = Duration(seconds: 30);

  // Default Rating
  static const double defaultRating = 5.0;

  // Image Sizes
  static const double workerImageSize = 90;
  static const double categoryImageSize = 70;

  // Default Padding
  static const double defaultPadding = 16;

  // Border Radius
  static const double defaultRadius = 12;

  // Booking Status
  static const String pending = "Pending";
  static const String accepted = "Accepted";
  static const String completed = "Completed";
  static const String cancelled = "Cancelled";

  // User Roles
  static const String customer = "Customer";
  static const String worker = "Worker";
  static const String admin = "Admin";
}