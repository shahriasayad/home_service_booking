class WorkerModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String profession;
  final List<String> serviceCategories;
  final String experience;
  final double rating;
  final double price;
  final String image;
  final String phone;
  final String location;
  final List<String> serviceAreas;
  final String bio;
  final String approvalStatus;
  final bool isAvailable;
  final List<String> workingDays;
  final String startTime;
  final String endTime;
  final int completedJobs;

  WorkerModel({
    required this.id,
    required this.name,
    this.email = '',
    this.password = '123456',
    required this.profession,
    List<String>? serviceCategories,
    required this.experience,
    required this.rating,
    this.price = 500.0,
    required this.image,
    required this.phone,
    required this.location,
    List<String>? serviceAreas,
    this.bio = 'Experienced and verified home service professional.',
    this.approvalStatus = 'Approved',
    this.isAvailable = true,
    List<String>? workingDays,
    this.startTime = '09:00 AM',
    this.endTime = '06:00 PM',
    this.completedJobs = 12,
  })  : serviceCategories = (serviceCategories != null && serviceCategories.isNotEmpty)
            ? serviceCategories
            : [profession],
        serviceAreas = (serviceAreas != null && serviceAreas.isNotEmpty)
            ? serviceAreas
            : [location],
        workingDays = (workingDays != null && workingDays.isNotEmpty)
            ? workingDays
            : const ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];

  bool matchesCategory(String categoryQuery) {
    final q = categoryQuery.trim().toLowerCase();
    if (q.isEmpty || q == 'all') return true;
    if (profession.toLowerCase() == q) return true;
    return serviceCategories.any((c) => c.toLowerCase() == q);
  }

  bool matchesArea(String areaQuery) {
    final q = areaQuery.trim().toLowerCase();
    if (q.isEmpty || q == 'all' || q == 'all areas') return true;
    if (location.toLowerCase().contains(q)) return true;
    return serviceAreas.any((a) => a.toLowerCase().contains(q));
  }

  WorkerModel copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? profession,
    List<String>? serviceCategories,
    String? experience,
    double? rating,
    double? price,
    String? image,
    String? phone,
    String? location,
    List<String>? serviceAreas,
    String? bio,
    String? approvalStatus,
    bool? isAvailable,
    List<String>? workingDays,
    String? startTime,
    String? endTime,
    int? completedJobs,
  }) {
    return WorkerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profession: profession ?? this.profession,
      serviceCategories: serviceCategories ?? this.serviceCategories,
      experience: experience ?? this.experience,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      serviceAreas: serviceAreas ?? this.serviceAreas,
      bio: bio ?? this.bio,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      isAvailable: isAvailable ?? this.isAvailable,
      workingDays: workingDays ?? this.workingDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      completedJobs: completedJobs ?? this.completedJobs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'profession': profession,
      'serviceCategories': serviceCategories,
      'experience': experience,
      'rating': rating,
      'price': price,
      'image': image,
      'phone': phone,
      'location': location,
      'serviceAreas': serviceAreas,
      'bio': bio,
      'approvalStatus': approvalStatus,
      'isAvailable': isAvailable,
      'workingDays': workingDays,
      'startTime': startTime,
      'endTime': endTime,
      'completedJobs': completedJobs,
    };
  }

  factory WorkerModel.fromMap(Map<dynamic, dynamic> map) {
    final profession = (map['profession'] ?? 'Electrician').toString();
    final location = (map['location'] ?? 'Mymensingh').toString();
    final rawCategories = map['serviceCategories'];
    final rawAreas = map['serviceAreas'];
    final rawDays = map['workingDays'];

    return WorkerModel(
      id: (map['id'] as num?)?.toInt() ?? 0,
      name: (map['name'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
      password: (map['password'] ?? '123456').toString(),
      profession: profession,
      serviceCategories: rawCategories is List
          ? rawCategories.map((e) => e.toString()).toList()
          : [profession],
      experience: (map['experience'] ?? '3 Years').toString(),
      rating: (map['rating'] as num?)?.toDouble() ?? 4.5,
      price: (map['price'] as num?)?.toDouble() ?? 500.0,
      image: (map['image'] ?? 'assets/images/worker1.png').toString(),
      phone: (map['phone'] ?? '').toString(),
      location: location,
      serviceAreas: rawAreas is List
          ? rawAreas.map((e) => e.toString()).toList()
          : [location],
      bio: (map['bio'] ?? 'Experienced and verified home service professional.').toString(),
      approvalStatus: (map['approvalStatus'] ?? 'Approved').toString(),
      isAvailable: map['isAvailable'] as bool? ?? true,
      workingDays: rawDays is List
          ? rawDays.map((e) => e.toString()).toList()
          : const ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'],
      startTime: (map['startTime'] ?? '09:00 AM').toString(),
      endTime: (map['endTime'] ?? '06:00 PM').toString(),
      completedJobs: (map['completedJobs'] as num?)?.toInt() ?? 10,
    );
  }
}
