class ReviewModel {
  final String id;
  final int workerId;
  final String workerName;
  final String bookingId;
  final String userName;
  final int rating;
  final String review;
  final String date;

  ReviewModel({
    String? id,
    this.workerId = 1,
    this.workerName = 'Rakib Hasan',
    this.bookingId = '',
    required this.userName,
    required this.rating,
    required this.review,
    String? date,
  })  : id = id ?? 'REV-${DateTime.now().millisecondsSinceEpoch}',
        date = date ?? '12 Aug 2026';

  ReviewModel copyWith({
    String? id,
    int? workerId,
    String? workerName,
    String? bookingId,
    String? userName,
    int? rating,
    String? review,
    String? date,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      workerName: workerName ?? this.workerName,
      bookingId: bookingId ?? this.bookingId,
      userName: userName ?? this.userName,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workerId': workerId,
      'workerName': workerName,
      'bookingId': bookingId,
      'userName': userName,
      'rating': rating,
      'review': review,
      'date': date,
    };
  }

  factory ReviewModel.fromMap(Map<dynamic, dynamic> map) {
    return ReviewModel(
      id: map['id']?.toString(),
      workerId: (map['workerId'] as num?)?.toInt() ?? 1,
      workerName: (map['workerName'] ?? 'Rakib Hasan').toString(),
      bookingId: (map['bookingId'] ?? '').toString(),
      userName: (map['userName'] ?? 'Customer').toString(),
      rating: (map['rating'] as num?)?.round() ?? 5,
      review: (map['review'] ?? '').toString(),
      date: map['date']?.toString(),
    );
  }
}
