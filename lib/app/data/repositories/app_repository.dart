import 'package:get/get.dart';

import '../../utils/date_formatter.dart';
import '../dummy_data.dart';
import '../models/booking_model.dart';
import '../models/category_model.dart';
import '../models/payment_model.dart';
import '../models/review_model.dart';
import '../models/user_model.dart';
import '../models/worker_model.dart';
import '../services/local_storage_service.dart';

class AppRepository extends GetxService {
  static AppRepository get to {
    if (Get.isRegistered<AppRepository>()) {
      return Get.find<AppRepository>();
    }
    final storage = Get.isRegistered<LocalStorageService>()
        ? Get.find<LocalStorageService>()
        : Get.put(LocalStorageService(), permanent: true);
    final repo = AppRepository(storage);
    repo.loadInitialData();
    return Get.put(repo, permanent: true);
  }

  static const String _categoriesKey = 'categories';
  static const String _usersKey = 'users';
  static const String _workersKey = 'workers';
  static const String _bookingsKey = 'bookings';
  static const String _reviewsKey = 'reviews';
  static const String _paymentsKey = 'payments';

  static const String _currentRoleKey = 'current_role';
  static const String _currentUserIdKey = 'current_user_id';
  static const String _currentWorkerIdKey = 'current_worker_id';

  final LocalStorageService _storage;

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<WorkerModel> workers = <WorkerModel>[].obs;
  final RxList<BookingModel> bookings = <BookingModel>[].obs;
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxList<PaymentRecordModel> payments = <PaymentRecordModel>[].obs;

  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final Rxn<WorkerModel> currentWorker = Rxn<WorkerModel>();
  final RxString currentRole = ''.obs;

  /// Active draft booking created in BookingController before Payment confirmation
  final Rxn<BookingModel> draftBooking = Rxn<BookingModel>();
  final Rxn<BookingModel> lastConfirmedBooking = Rxn<BookingModel>();

  AppRepository(this._storage);

  void loadInitialData() {
    final storedCategories = _storage.getList(_categoriesKey);
    if (storedCategories != null && storedCategories.isNotEmpty) {
      categories.assignAll(storedCategories.map(CategoryModel.fromMap));
    } else {
      categories.assignAll(DummyData.categories);
      _persistCategories();
    }

    final storedUsers = _storage.getList(_usersKey);
    if (storedUsers != null && storedUsers.isNotEmpty) {
      users.assignAll(storedUsers.map(UserModel.fromMap));
    } else {
      users.assignAll(DummyData.users);
      _persistUsers();
    }

    final storedWorkers = _storage.getList(_workersKey);
    if (storedWorkers != null && storedWorkers.isNotEmpty) {
      workers.assignAll(storedWorkers.map(WorkerModel.fromMap));
    } else {
      workers.assignAll(DummyData.workers);
      _persistWorkers();
    }

    final storedBookings = _storage.getList(_bookingsKey);
    if (storedBookings != null) {
      bookings.assignAll(storedBookings.map(BookingModel.fromMap));
    } else {
      bookings.assignAll(DummyData.bookingHistory);
      _persistBookings();
    }

    final storedReviews = _storage.getList(_reviewsKey);
    if (storedReviews != null) {
      reviews.assignAll(storedReviews.map(ReviewModel.fromMap));
    } else {
      reviews.assignAll(DummyData.reviews);
      _persistReviews();
    }

    final storedPayments = _storage.getList(_paymentsKey);
    if (storedPayments != null) {
      payments.assignAll(storedPayments.map(PaymentRecordModel.fromMap));
    } else {
      payments.assignAll(DummyData.initialPaymentRecords);
      _persistPayments();
    }

    // Restore session
    final savedRole = _storage.getSetting<String>(_currentRoleKey, defaultValue: '') ?? '';
    currentRole.value = savedRole;

    final savedUserId = _storage.getSetting<int>(_currentUserIdKey);
    if (savedUserId != null) {
      currentUser.value = users.firstWhereOrNull((u) => u.id == savedUserId) ??
          (users.isNotEmpty ? users.first : null);
    } else if (users.isNotEmpty) {
      currentUser.value = users.first;
    }

    final savedWorkerId = _storage.getSetting<int>(_currentWorkerIdKey);
    if (savedWorkerId != null) {
      currentWorker.value = workers.firstWhereOrNull((w) => w.id == savedWorkerId) ??
          (workers.isNotEmpty ? workers.first : null);
    } else if (workers.isNotEmpty) {
      currentWorker.value = workers.first;
    }
  }

  List<String> get availableAreas {
    final areaSet = <String>{...DummyData.defaultAreas};
    for (final w in workers) {
      if (w.location.trim().isNotEmpty) areaSet.add(w.location.trim());
      for (final a in w.serviceAreas) {
        if (a.trim().isNotEmpty) areaSet.add(a.trim());
      }
    }
    for (final u in users) {
      if (u.area.trim().isNotEmpty) areaSet.add(u.area.trim());
    }
    return areaSet.toList();
  }

  // ==========================
  // AUTHENTICATION & PROFILES
  // ==========================

  Future<String?> login({
    required String email,
    required String password,
    required String role,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (role == 'Admin') {
      currentRole.value = 'Admin';
      await _storage.setSetting(_currentRoleKey, 'Admin');
      return null;
    }

    if (role == 'Worker') {
      final existingWorker = workers.firstWhereOrNull(
        (w) => w.email.trim().toLowerCase() == normalizedEmail,
      );
      if (existingWorker != null) {
        if (existingWorker.password.isNotEmpty &&
            existingWorker.password != password) {
          return 'Incorrect password. Please try again.';
        }
        if (existingWorker.approvalStatus == 'Rejected') {
          return 'Your worker account has been rejected by Admin.';
        }
        currentWorker.value = existingWorker;
      } else {
        currentWorker.value = workers.isNotEmpty ? workers.first : null;
      }
      currentRole.value = 'Worker';
      await _storage.setSetting(_currentRoleKey, 'Worker');
      if (currentWorker.value != null) {
        await _storage.setSetting(_currentWorkerIdKey, currentWorker.value!.id);
      }
      return null;
    }

    // Default: Customer
    final existingUser = users.firstWhereOrNull(
      (u) => u.email.trim().toLowerCase() == normalizedEmail,
    );
    if (existingUser != null) {
      if (existingUser.password.isNotEmpty &&
          existingUser.password != password) {
        return 'Incorrect password. Please try again.';
      }
      if (!existingUser.isActive) {
        return 'Your account has been suspended by Admin.';
      }
      currentUser.value = existingUser;
    } else {
      final derivedName = normalizedEmail.split('@').first;
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: derivedName.isNotEmpty
            ? '${derivedName[0].toUpperCase()}${derivedName.substring(1)}'
            : 'Customer',
        email: email.trim(),
        phone: '01712345678',
        address: 'Mymensingh',
        area: 'Mymensingh',
        password: password,
      );
      users.add(newUser);
      await _persistUsers();
      currentUser.value = newUser;
    }

    currentRole.value = 'Customer';
    await _storage.setSetting(_currentRoleKey, 'Customer');
    if (currentUser.value != null) {
      await _storage.setSetting(_currentUserIdKey, currentUser.value!.id);
    }
    return null;
  }

  Future<UserModel> registerCustomer({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String area,
    required String password,
  }) async {
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name.trim(),
      email: email.trim(),
      phone: phone.trim(),
      address: address.trim(),
      area: area.trim().isNotEmpty ? area.trim() : null,
      password: password,
    );
    users.add(newUser);
    currentUser.value = newUser;
    currentRole.value = 'Customer';
    await _persistUsers();
    await _storage.setSetting(_currentRoleKey, 'Customer');
    await _storage.setSetting(_currentUserIdKey, newUser.id);
    return newUser;
  }

  Future<WorkerModel> registerWorker({
    required String name,
    required String email,
    required String phone,
    required String profession,
    List<String>? serviceCategories,
    required String experience,
    required String location,
    List<String>? serviceAreas,
    double price = 500.0,
    String bio = 'Experienced and verified home service professional.',
    required String password,
  }) async {
    final formattedExp = experience.toLowerCase().contains('year')
        ? experience.trim()
        : '${experience.trim()} Years';
    final newWorker = WorkerModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name.trim(),
      email: email.trim(),
      password: password,
      profession: profession.trim(),
      serviceCategories: serviceCategories,
      experience: formattedExp,
      rating: 5.0,
      price: price,
      image: 'assets/images/worker1.png',
      phone: phone.trim(),
      location: location.trim(),
      serviceAreas: serviceAreas,
      bio: bio.trim(),
      approvalStatus: 'Approved',
      isAvailable: true,
      completedJobs: 0,
    );
    workers.add(newWorker);
    currentWorker.value = newWorker;
    currentRole.value = 'Worker';
    await _persistWorkers();
    await _storage.setSetting(_currentRoleKey, 'Worker');
    await _storage.setSetting(_currentWorkerIdKey, newWorker.id);
    return newWorker;
  }

  Future<void> updateCustomerProfile(UserModel updated) async {
    final index = users.indexWhere((u) => u.id == updated.id);
    if (index != -1) {
      users[index] = updated;
    } else {
      users.add(updated);
    }
    currentUser.value = updated;
    users.refresh();
    await _persistUsers();
  }

  Future<void> updateWorkerProfile(WorkerModel updated) async {
    final index = workers.indexWhere((w) => w.id == updated.id);
    if (index != -1) {
      workers[index] = updated;
    } else {
      workers.add(updated);
    }
    if (currentWorker.value?.id == updated.id) {
      currentWorker.value = updated;
    }
    workers.refresh();
    await _persistWorkers();
  }

  Future<void> logout() async {
    currentRole.value = '';
    await _storage.setSetting(_currentRoleKey, '');
  }

  // ==========================
  // CATEGORY MANAGEMENT
  // ==========================

  Future<CategoryModel> addCategory({
    required String name,
    String? image,
    String description = '',
  }) async {
    final category = CategoryModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name.trim(),
      image: image ?? _resolveCategoryIcon(name),
      description: description.trim().isNotEmpty
          ? description.trim()
          : 'Professional ${name.trim()} home service',
    );
    categories.add(category);
    await _persistCategories();
    return category;
  }

  Future<void> updateCategory(CategoryModel updated) async {
    final index = categories.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      categories[index] = updated;
      categories.refresh();
      await _persistCategories();
    }
  }

  Future<void> deleteCategory(int id) async {
    categories.removeWhere((c) => c.id == id);
    await _persistCategories();
  }

  String _resolveCategoryIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('electric')) return 'assets/icons/electrician.png';
    if (lower.contains('plumb')) return 'assets/icons/plumber.png';
    if (lower.contains('clean')) return 'assets/icons/cleaner.png';
    if (lower.contains('paint')) return 'assets/icons/painter.png';
    if (lower.contains('ac') || lower.contains('air')) return 'assets/icons/ac_repair.png';
    return 'assets/icons/category.png';
  }

  // ==========================
  // WORKER & USER ADMIN OPS
  // ==========================

  Future<void> updateWorkerApproval(int workerId, String status) async {
    final index = workers.indexWhere((w) => w.id == workerId);
    if (index != -1) {
      final updated = workers[index].copyWith(approvalStatus: status);
      workers[index] = updated;
      if (currentWorker.value?.id == workerId) {
        currentWorker.value = updated;
      }
      workers.refresh();
      await _persistWorkers();
    }
  }

  Future<void> deleteWorkerById(int workerId) async {
    workers.removeWhere((w) => w.id == workerId);
    await _persistWorkers();
  }

  Future<void> toggleUserActiveStatus(int userId) async {
    final index = users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final current = users[index];
      users[index] = current.copyWith(isActive: !current.isActive);
      users.refresh();
      await _persistUsers();
    }
  }

  Future<void> deleteUserById(int userId) async {
    users.removeWhere((u) => u.id == userId);
    await _persistUsers();
  }

  // ==========================
  // BOOKING & MOCK PAYMENTS
  // ==========================

  bool hasSuccessfulPaymentForBooking(String bookingId) {
    return payments.any(
      (p) => p.bookingId == bookingId && p.status == 'Paid',
    );
  }

  Future<PaymentRecordModel> processBookingPayment({
    required BookingModel booking,
    required String paymentMethod,
    required String simulatedOutcome, // 'Success', 'Pending', 'Failed', 'Cancelled'
    String simulatedAccount = '',
  }) async {
    if (hasSuccessfulPaymentForBooking(booking.id)) {
      throw StateError('Payment has already been completed for this booking.');
    }

    final nowStr = DateFormatter.formatDateTime(DateTime.now());
    final paymentId = 'PAY-${DateTime.now().millisecondsSinceEpoch}';
    final prefix = paymentMethod.toUpperCase().replaceAll(' ', '');
    final txRef = 'SIM-$prefix-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    String recordStatus;
    String bookingPaymentStatus;

    if (paymentMethod == 'Cash on Service') {
      recordStatus = 'Pay on Service';
      bookingPaymentStatus = 'Pay on Service';
    } else if (simulatedOutcome == 'Success') {
      recordStatus = 'Paid';
      bookingPaymentStatus = 'Paid';
    } else if (simulatedOutcome == 'Pending') {
      recordStatus = 'Pending';
      bookingPaymentStatus = 'Pending';
    } else if (simulatedOutcome == 'Cancelled') {
      recordStatus = 'Cancelled';
      bookingPaymentStatus = 'Cancelled';
    } else {
      recordStatus = 'Failed';
      bookingPaymentStatus = 'Failed';
    }

    final paymentRecord = PaymentRecordModel(
      id: paymentId,
      bookingId: booking.id,
      customerId: booking.customerId,
      workerId: booking.workerId,
      amount: booking.amount,
      method: paymentMethod,
      status: recordStatus,
      transactionRef: txRef,
      simulatedAccount: simulatedAccount.trim().isNotEmpty
          ? simulatedAccount.trim()
          : booking.customerPhone,
      timestamp: nowStr,
      isSimulated: true,
    );

    payments.insert(0, paymentRecord);
    await _persistPayments();

    // Only create/update the booking when payment is not Failed/Cancelled
    if (recordStatus != 'Failed' && recordStatus != 'Cancelled') {
      final confirmedBooking = booking.copyWith(
        paymentMethod: paymentMethod,
        paymentStatus: bookingPaymentStatus,
        paymentId: paymentId,
      );

      final existingIndex = bookings.indexWhere((b) => b.id == confirmedBooking.id);
      if (existingIndex != -1) {
        bookings[existingIndex] = confirmedBooking;
      } else {
        bookings.insert(0, confirmedBooking);
      }
      bookings.refresh();
      lastConfirmedBooking.value = confirmedBooking;
      draftBooking.value = null;
      await _persistBookings();
    }

    return paymentRecord;
  }

  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    final index = bookings.indexWhere((b) => b.id == bookingId);
    if (index == -1) return;

    final current = bookings[index];
    String updatedPaymentStatus = current.paymentStatus;

    if (newStatus == 'Completed' &&
        (current.paymentMethod == 'Cash on Service' ||
            current.paymentStatus == 'Pay on Service' ||
            current.paymentStatus == 'Pending')) {
      updatedPaymentStatus = 'Paid';
      final payIdx = payments.indexWhere((p) => p.bookingId == bookingId);
      if (payIdx != -1) {
        payments[payIdx] = payments[payIdx].copyWith(status: 'Paid');
        payments.refresh();
        await _persistPayments();
      }
    } else if ((newStatus == 'Cancelled' || newStatus == 'Rejected') &&
        current.paymentStatus == 'Paid') {
      updatedPaymentStatus = 'Refunded (Simulated)';
      final payIdx = payments.indexWhere((p) => p.bookingId == bookingId);
      if (payIdx != -1) {
        payments[payIdx] = payments[payIdx].copyWith(status: 'Refunded');
        payments.refresh();
        await _persistPayments();
      }
    }

    final updated = current.copyWith(
      status: newStatus,
      paymentStatus: updatedPaymentStatus,
    );
    bookings[index] = updated;
    bookings.refresh();
    await _persistBookings();

    if (newStatus == 'Completed') {
      final wIdx = workers.indexWhere((w) => w.id == current.workerId);
      if (wIdx != -1) {
        final w = workers[wIdx];
        final updatedWorker = w.copyWith(completedJobs: w.completedJobs + 1);
        workers[wIdx] = updatedWorker;
        if (currentWorker.value?.id == updatedWorker.id) {
          currentWorker.value = updatedWorker;
        }
        workers.refresh();
        await _persistWorkers();
      }
    }
  }

  // ==========================
  // REVIEWS & RATINGS
  // ==========================

  List<ReviewModel> getReviewsForWorker(int workerId, String workerName) {
    return reviews
        .where(
          (r) =>
              r.workerId == workerId ||
              r.workerName.toLowerCase() == workerName.toLowerCase(),
        )
        .toList();
  }

  Future<ReviewModel> addReview({
    required int workerId,
    required String workerName,
    String bookingId = '',
    required String userName,
    required int rating,
    required String comment,
  }) async {
    final review = ReviewModel(
      id: 'REV-${DateTime.now().millisecondsSinceEpoch}',
      workerId: workerId,
      workerName: workerName,
      bookingId: bookingId,
      userName: userName,
      rating: rating,
      review: comment.trim(),
      date: DateFormatter.formatDate(DateTime.now()),
    );

    reviews.insert(0, review);
    await _persistReviews();

    if (bookingId.isNotEmpty) {
      final bIdx = bookings.indexWhere((b) => b.id == bookingId);
      if (bIdx != -1) {
        bookings[bIdx] = bookings[bIdx].copyWith(isReviewed: true);
        bookings.refresh();
        await _persistBookings();
      }
    }

    _recalculateWorkerRating(workerId, workerName);
    return review;
  }

  Future<void> deleteReview(String reviewId) async {
    final target = reviews.firstWhereOrNull((r) => r.id == reviewId);
    reviews.removeWhere((r) => r.id == reviewId);
    await _persistReviews();
    if (target != null) {
      _recalculateWorkerRating(target.workerId, target.workerName);
    }
  }

  void _recalculateWorkerRating(int workerId, String workerName) {
    final workerReviews = getReviewsForWorker(workerId, workerName);
    if (workerReviews.isEmpty) return;

    final total = workerReviews.fold<int>(0, (sum, r) => sum + r.rating);
    final avg = double.parse((total / workerReviews.length).toStringAsFixed(1));

    final wIdx = workers.indexWhere(
      (w) => w.id == workerId || w.name.toLowerCase() == workerName.toLowerCase(),
    );
    if (wIdx != -1) {
      final updatedWorker = workers[wIdx].copyWith(rating: avg);
      workers[wIdx] = updatedWorker;
      if (currentWorker.value?.id == updatedWorker.id) {
        currentWorker.value = updatedWorker;
      }
      workers.refresh();
      _persistWorkers();
    }
  }

  // ==========================
  // PERSISTENCE HELPERS
  // ==========================

  Future<void> _persistCategories() async {
    await _storage.saveList(
      _categoriesKey,
      categories.map((e) => e.toMap()).toList(),
    );
  }

  Future<void> _persistUsers() async {
    await _storage.saveList(
      _usersKey,
      users.map((e) => e.toMap()).toList(),
    );
  }

  Future<void> _persistWorkers() async {
    await _storage.saveList(
      _workersKey,
      workers.map((e) => e.toMap()).toList(),
    );
  }

  Future<void> _persistBookings() async {
    await _storage.saveList(
      _bookingsKey,
      bookings.map((e) => e.toMap()).toList(),
    );
  }

  Future<void> _persistReviews() async {
    await _storage.saveList(
      _reviewsKey,
      reviews.map((e) => e.toMap()).toList(),
    );
  }

  Future<void> _persistPayments() async {
    await _storage.saveList(
      _paymentsKey,
      payments.map((e) => e.toMap()).toList(),
    );
  }
}
