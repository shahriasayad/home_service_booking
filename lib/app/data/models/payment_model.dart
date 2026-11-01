class PaymentModel {
  final String title;
  final String icon;
  final String subtitle;
  final bool requiresSimulation;

  PaymentModel({
    required this.title,
    required this.icon,
    this.subtitle = '',
    this.requiresSimulation = false,
  });
}

class PaymentRecordModel {
  final String id;
  final String bookingId;
  final int customerId;
  final int workerId;
  final double amount;
  final String method;
  final String status; // Paid, Pending, Pay on Service, Failed, Cancelled
  final String transactionRef;
  final String simulatedAccount;
  final String timestamp;
  final bool isSimulated;

  PaymentRecordModel({
    required this.id,
    required this.bookingId,
    required this.customerId,
    required this.workerId,
    required this.amount,
    required this.method,
    required this.status,
    required this.transactionRef,
    this.simulatedAccount = '',
    required this.timestamp,
    this.isSimulated = true,
  });

  PaymentRecordModel copyWith({
    String? id,
    String? bookingId,
    int? customerId,
    int? workerId,
    double? amount,
    String? method,
    String? status,
    String? transactionRef,
    String? simulatedAccount,
    String? timestamp,
    bool? isSimulated,
  }) {
    return PaymentRecordModel(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      customerId: customerId ?? this.customerId,
      workerId: workerId ?? this.workerId,
      amount: amount ?? this.amount,
      method: method ?? this.method,
      status: status ?? this.status,
      transactionRef: transactionRef ?? this.transactionRef,
      simulatedAccount: simulatedAccount ?? this.simulatedAccount,
      timestamp: timestamp ?? this.timestamp,
      isSimulated: isSimulated ?? this.isSimulated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookingId': bookingId,
      'customerId': customerId,
      'workerId': workerId,
      'amount': amount,
      'method': method,
      'status': status,
      'transactionRef': transactionRef,
      'simulatedAccount': simulatedAccount,
      'timestamp': timestamp,
      'isSimulated': isSimulated,
    };
  }

  factory PaymentRecordModel.fromMap(Map<dynamic, dynamic> map) {
    return PaymentRecordModel(
      id: (map['id'] ?? '').toString(),
      bookingId: (map['bookingId'] ?? '').toString(),
      customerId: (map['customerId'] as num?)?.toInt() ?? 1,
      workerId: (map['workerId'] as num?)?.toInt() ?? 1,
      amount: (map['amount'] as num?)?.toDouble() ?? 500.0,
      method: (map['method'] ?? 'Cash on Service').toString(),
      status: (map['status'] ?? 'Pending').toString(),
      transactionRef: (map['transactionRef'] ?? '').toString(),
      simulatedAccount: (map['simulatedAccount'] ?? '').toString(),
      timestamp: (map['timestamp'] ?? '').toString(),
      isSimulated: map['isSimulated'] as bool? ?? true,
    );
  }
}
