class BookingModel {
  final String id;
  final int workerId;
  final String workerName;
  final String profession;
  final int customerId;
  final String customerName;
  final String customerPhone;
  final String address;
  final String area;
  final String date;
  final String time;
  final String note;
  final String status;
  final String image;
  final double amount;
  final String paymentMethod;
  final String paymentStatus;
  final String paymentId;
  final bool isReviewed;
  final String createdAt;

  BookingModel({
    String? id,
    this.workerId = 1,
    required this.workerName,
    required this.profession,
    this.customerId = 1,
    this.customerName = 'Nusrat Orpi',
    this.customerPhone = '01712345678',
    this.address = 'Mymensingh Sadar, Mymensingh',
    this.area = 'Mymensingh',
    required this.date,
    required this.time,
    this.note = '',
    required this.status,
    required this.image,
    this.amount = 500.0,
    this.paymentMethod = 'Cash on Service',
    this.paymentStatus = 'Pay on Service',
    this.paymentId = '',
    this.isReviewed = false,
    String? createdAt,
  })  : id = id ?? 'BK-${DateTime.now().millisecondsSinceEpoch}',
        createdAt = createdAt ?? DateTime.now().toIso8601String();

  BookingModel copyWith({
    String? id,
    int? workerId,
    String? workerName,
    String? profession,
    int? customerId,
    String? customerName,
    String? customerPhone,
    String? address,
    String? area,
    String? date,
    String? time,
    String? note,
    String? status,
    String? image,
    double? amount,
    String? paymentMethod,
    String? paymentStatus,
    String? paymentId,
    bool? isReviewed,
    String? createdAt,
  }) {
    return BookingModel(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      workerName: workerName ?? this.workerName,
      profession: profession ?? this.profession,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      address: address ?? this.address,
      area: area ?? this.area,
      date: date ?? this.date,
      time: time ?? this.time,
      note: note ?? this.note,
      status: status ?? this.status,
      image: image ?? this.image,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentId: paymentId ?? this.paymentId,
      isReviewed: isReviewed ?? this.isReviewed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workerId': workerId,
      'workerName': workerName,
      'profession': profession,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'address': address,
      'area': area,
      'date': date,
      'time': time,
      'note': note,
      'status': status,
      'image': image,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentId': paymentId,
      'isReviewed': isReviewed,
      'createdAt': createdAt,
    };
  }

  factory BookingModel.fromMap(Map<dynamic, dynamic> map) {
    return BookingModel(
      id: map['id']?.toString(),
      workerId: (map['workerId'] as num?)?.toInt() ?? 1,
      workerName: (map['workerName'] ?? '').toString(),
      profession: (map['profession'] ?? '').toString(),
      customerId: (map['customerId'] as num?)?.toInt() ?? 1,
      customerName: (map['customerName'] ?? 'Nusrat Orpi').toString(),
      customerPhone: (map['customerPhone'] ?? '01712345678').toString(),
      address: (map['address'] ?? 'Mymensingh').toString(),
      area: (map['area'] ?? 'Mymensingh').toString(),
      date: (map['date'] ?? '').toString(),
      time: (map['time'] ?? '').toString(),
      note: (map['note'] ?? '').toString(),
      status: (map['status'] ?? 'Pending').toString(),
      image: (map['image'] ?? 'assets/images/worker1.png').toString(),
      amount: (map['amount'] as num?)?.toDouble() ?? 500.0,
      paymentMethod: (map['paymentMethod'] ?? 'Cash on Service').toString(),
      paymentStatus: (map['paymentStatus'] ?? 'Pay on Service').toString(),
      paymentId: (map['paymentId'] ?? '').toString(),
      isReviewed: map['isReviewed'] as bool? ?? false,
      createdAt: map['createdAt']?.toString(),
    );
  }
}
