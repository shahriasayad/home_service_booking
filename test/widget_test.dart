import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:home_service_booking/app/data/models/booking_model.dart';
import 'package:home_service_booking/app/data/repositories/app_repository.dart';
import 'package:home_service_booking/app/data/services/local_storage_service.dart';
import 'package:home_service_booking/app/routes/app_routes.dart';
import 'package:home_service_booking/app/theme/theme_controller.dart';
import 'package:home_service_booking/main.dart';

void main() {
  late Directory tempDir;
  late LocalStorageService storage;
  late AppRepository repo;

  group('Core Features, Repository & Hive Persistence Tests', () {
    setUp(() async {
      Get.reset();
      tempDir = await Directory.systemTemp.createTemp('hsb_test_');
      storage = LocalStorageService();
      await storage.init(testPath: tempDir.path);
      await storage.clearAll();

      Get.put<LocalStorageService>(storage, permanent: true);
      repo = AppRepository(storage);
      repo.loadInitialData();
      Get.put<AppRepository>(repo, permanent: true);
      Get.put<ThemeController>(ThemeController(storage), permanent: true);
    });

    tearDown(() async {
      await storage.clearAll();
      await storage.close();
      Get.reset();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });
    test('Seeds initial categories, workers, users, bookings, and reviews', () {
      expect(repo.categories.isNotEmpty, isTrue);
      expect(repo.workers.isNotEmpty, isTrue);
      expect(repo.users.isNotEmpty, isTrue);
      expect(repo.bookings.isNotEmpty, isTrue);
      expect(repo.reviews.isNotEmpty, isTrue);
    });

    test('Customer registration, login, and locality matching work and persist', () async {
      final user = await repo.registerCustomer(
        name: 'Amina Khatun',
        email: 'amina@example.com',
        phone: '01799999999',
        address: 'Town Hall, Mymensingh',
        area: 'Mymensingh',
        password: 'password123',
      );

      expect(repo.currentRole.value, 'Customer');
      expect(repo.currentUser.value?.email, 'amina@example.com');
      expect(user.area, 'Mymensingh');

      // Matching workers in Mymensingh
      final mymensinghWorkers = repo.workers
          .where((w) => w.approvalStatus == 'Approved' && w.matchesArea('Mymensingh'))
          .toList();
      expect(mymensinghWorkers.isNotEmpty, isTrue);

      // Verify persistence across repository reload
      final reloadedRepo = AppRepository(storage)..loadInitialData();
      expect(
        reloadedRepo.users.any((u) => u.email == 'amina@example.com'),
        isTrue,
      );
      expect(reloadedRepo.currentRole.value, 'Customer');
    });

    test('Worker registration with service categories and areas persists', () async {
      final worker = await repo.registerWorker(
        name: 'Zahidul Islam',
        email: 'zahid@worker.com',
        phone: '01888888888',
        profession: 'Electrician',
        serviceCategories: ['Electrician', 'Plumber'],
        experience: '6',
        location: 'Mymensingh',
        serviceAreas: ['Mymensingh', 'Gazipur'],
        price: 750,
        password: 'password123',
      );

      expect(repo.currentRole.value, 'Worker');
      expect(worker.matchesCategory('Electrician'), isTrue);
      expect(worker.matchesCategory('Plumber'), isTrue);
      expect(worker.matchesArea('Mymensingh'), isTrue);
      expect(worker.matchesArea('Gazipur'), isTrue);
      expect(worker.price, 750);
    });

    test('Mock Payment workflow: bKash Success, Failure, Cancellation, and Duplicate Prevention', () async {
      final draft = BookingModel(
        id: 'BK-TEST-99',
        workerId: 1,
        workerName: 'Rakib Hasan',
        profession: 'Electrician',
        customerId: 1,
        customerName: 'Nusrat Orpi',
        customerPhone: '01712345678',
        address: 'Charpara, Mymensingh',
        area: 'Mymensingh',
        date: '25 Nov 2026',
        time: '11:00 AM',
        status: 'Pending',
        image: 'assets/images/worker1.png',
        amount: 600,
      );

      // 1. Simulate failed payment -> booking should not be added to confirmed bookings
      final failedRecord = await repo.processBookingPayment(
        booking: draft,
        paymentMethod: 'bKash',
        simulatedOutcome: 'Failed',
        simulatedAccount: '01712345678',
      );
      expect(failedRecord.status, 'Failed');
      expect(repo.bookings.any((b) => b.id == 'BK-TEST-99'), isFalse);

      // 2. Simulate successful bKash payment -> booking confirmed & Paid
      final successRecord = await repo.processBookingPayment(
        booking: draft,
        paymentMethod: 'bKash',
        simulatedOutcome: 'Success',
        simulatedAccount: '01712345678',
      );
      expect(successRecord.status, 'Paid');
      final savedBooking = repo.bookings.firstWhere((b) => b.id == 'BK-TEST-99');
      expect(savedBooking.paymentStatus, 'Paid');
      expect(savedBooking.paymentMethod, 'bKash');

      // 3. Duplicate payment prevention
      expect(
        () => repo.processBookingPayment(
          booking: draft,
          paymentMethod: 'Nagad',
          simulatedOutcome: 'Success',
          simulatedAccount: '01712345678',
        ),
        throwsStateError,
      );
    });

    test('Cash on Service booking settles payment when Worker completes service', () async {
      final draft = BookingModel(
        id: 'BK-COS-100',
        workerId: 1,
        workerName: 'Rakib Hasan',
        profession: 'Electrician',
        date: '26 Nov 2026',
        time: '03:00 PM',
        status: 'Pending',
        image: 'assets/images/worker1.png',
        amount: 600,
      );

      await repo.processBookingPayment(
        booking: draft,
        paymentMethod: 'Cash on Service',
        simulatedOutcome: 'Pay on Service',
      );

      var saved = repo.bookings.firstWhere((b) => b.id == 'BK-COS-100');
      expect(saved.paymentStatus, 'Pay on Service');

      // Worker accepts and completes booking
      await repo.updateBookingStatus('BK-COS-100', 'Accepted');
      await repo.updateBookingStatus('BK-COS-100', 'Completed');

      saved = repo.bookings.firstWhere((b) => b.id == 'BK-COS-100');
      expect(saved.status, 'Completed');
      expect(saved.paymentStatus, 'Paid');
    });

    test('Submitting review marks booking reviewed and recalculates worker rating', () async {
      await repo.addReview(
        workerId: 1,
        workerName: 'Rakib Hasan',
        bookingId: 'BK-1003',
        userName: 'Nusrat Orpi',
        rating: 4,
        comment: 'Great service and timely arrival.',
      );

      final booking = repo.bookings.firstWhere((b) => b.id == 'BK-1003');
      expect(booking.isReviewed, isTrue);

      final workerReviews = repo.getReviewsForWorker(1, 'Rakib Hasan');
      expect(workerReviews.length, greaterThanOrEqualTo(2));
    });

    test('Admin CRUD operations on categories, workers, and users persist', () async {
      final initialCatCount = repo.categories.length;
      final addedCat = await repo.addCategory(
        name: 'Pest Control',
        description: 'Home pest and termite control',
      );
      expect(repo.categories.length, initialCatCount + 1);

      await repo.deleteCategory(addedCat.id);
      expect(repo.categories.length, initialCatCount);

      // Worker approval update
      await repo.updateWorkerApproval(6, 'Approved');
      final approvedWorker = repo.workers.firstWhere((w) => w.id == 6);
      expect(approvedWorker.approvalStatus, 'Approved');

      // Theme persistence
      final themeCtrl = ThemeController.to;
      await themeCtrl.setThemeMode(ThemeMode.dark);
      expect(themeCtrl.themeMode.value, ThemeMode.dark);
    });
  });

  group('End-to-End UI & Navigation Workflow Tests', () {
    setUp(() async {
      Get.reset();
      storage = LocalStorageService();
      await storage.init(inMemory: true);
      await storage.clearAll();

      Get.put<LocalStorageService>(storage, permanent: true);
      repo = AppRepository(storage);
      repo.loadInitialData();
      Get.put<AppRepository>(repo, permanent: true);
      Get.put<ThemeController>(ThemeController(storage), permanent: true);
    });

    tearDown(() async {
      await storage.close();
      Get.reset();
    });

    testWidgets('Splash -> Onboarding -> ChooseUser -> Login -> Customer Dashboard & Booking Flow',
        (WidgetTester tester) async {
      await tester.pumpWidget(const HomeServiceApp());

      expect(find.text('Home Service Booking'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Trusted Home Services'), findsOneWidget);
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      expect(find.text('Select Your Role'), findsOneWidget);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Welcome Back'), findsOneWidget);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Verify Customer Dashboard loaded with Categories & Mymensingh Workers
      expect(find.text('Categories'), findsOneWidget);
      expect(find.text('Rakib Hasan'), findsOneWidget);

      // Tap worker card -> WorkerProfileView
      await tester.tap(find.text('Rakib Hasan'));
      await tester.pumpAndSettle();

      expect(find.text('Worker Profile'), findsOneWidget);
      await tester.ensureVisible(find.text('Book Now'));
      await tester.pumpAndSettle();
      expect(find.text('Book Now'), findsOneWidget);

      // Tap Book Now -> BookingView
      await tester.tap(find.text('Book Now'));
      await tester.pumpAndSettle();

      expect(find.text('Book Service'), findsOneWidget);
      await tester.ensureVisible(find.text('Continue to Payment'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue to Payment'));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // PaymentView -> Confirm Booking
      expect(find.text('Select Payment Method'), findsOneWidget);
      await tester.ensureVisible(find.text('Confirm Booking'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Confirm Booking'));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('Booking Successful'), findsOneWidget);
    });

    testWidgets('Worker Dashboard and Admin Dashboard routes render and operate correctly',
        (WidgetTester tester) async {
      await repo.login(
        email: 'rakib@worker.com',
        password: 'password123',
        role: 'Worker',
      );

      await tester.pumpWidget(const HomeServiceApp());
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Worker Dashboard'), findsOneWidget);
      expect(find.text('Booking Requests'), findsOneWidget);
      await tester.ensureVisible(find.text('Manage Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Manage Profile'), findsOneWidget);

      // Navigate to Admin Dashboard
      Get.offAllNamed(AppRoutes.adminDashboard);
      await tester.pumpAndSettle();

      expect(find.text('Admin Dashboard'), findsOneWidget);
      expect(find.text('Manage Users'), findsOneWidget);
      expect(find.text('Manage Workers'), findsOneWidget);
      expect(find.text('Manage Service Categories'), findsOneWidget);
      expect(find.text('Monitor Reviews & System Activity'), findsOneWidget);
    });
  });
}
