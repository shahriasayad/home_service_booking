class CategoryModel {
  final int id;
  final String name;
  final String image;
  final String description;

  CategoryModel({
    int? id,
    required this.name,
    String? image,
    String? icon,
    this.description = '',
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch,
        image = image ?? icon ?? 'assets/icons/category.png';

  String get icon => image;

  CategoryModel copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
    };
  }

  factory CategoryModel.fromMap(Map<dynamic, dynamic> map) {
    return CategoryModel(
      id: (map['id'] as num?)?.toInt() ?? 0,
      name: (map['name'] ?? '').toString(),
      image: (map['image'] ?? map['icon'] ?? 'assets/icons/category.png').toString(),
      description: (map['description'] ?? '').toString(),
    );
  }
}
