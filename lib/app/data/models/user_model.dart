class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String area;
  final String image;
  final String role;
  final String password;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    String? area,
    this.image = 'assets/images/profile.png',
    this.role = 'Customer',
    this.password = '123456',
    this.isActive = true,
  }) : area = (area != null && area.trim().isNotEmpty)
            ? area.trim()
            : _extractArea(address);

  static String _extractArea(String address) {
    final trimmed = address.trim();
    if (trimmed.isEmpty) return 'Mymensingh';
    final parts = trimmed.split(',');
    return parts.first.trim();
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? area,
    String? image,
    String? role,
    String? password,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      area: area ?? this.area,
      image: image ?? this.image,
      role: role ?? this.role,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'area': area,
      'image': image,
      'role': role,
      'password': password,
      'isActive': isActive,
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      id: (map['id'] as num?)?.toInt() ?? 0,
      name: (map['name'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
      phone: (map['phone'] ?? '').toString(),
      address: (map['address'] ?? '').toString(),
      area: map['area']?.toString(),
      image: (map['image'] ?? 'assets/images/profile.png').toString(),
      role: (map['role'] ?? 'Customer').toString(),
      password: (map['password'] ?? '123456').toString(),
      isActive: map['isActive'] as bool? ?? true,
    );
  }
}
