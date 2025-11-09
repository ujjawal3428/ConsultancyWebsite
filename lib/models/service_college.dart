/// Model for colleges
class ServiceCollege {
  final String? id;
  final String degreeId; // Reference to ServiceDegree
  final String categoryId; // Reference to ServiceCategory
  final String name;
  final String state;
  final String city;
  final String iconName; // Icon name as string
  final String description;
  final String type; // 'Government' or 'Private'
  final String admissionDeadline;
  final int duration; // in months
  final int order;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServiceCollege({
    this.id,
    required this.degreeId,
    required this.categoryId,
    required this.name,
    required this.state,
    required this.city,
    required this.iconName,
    required this.description,
    required this.type,
    required this.admissionDeadline,
    required this.duration,
    this.order = 0,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceCollege.fromJson(Map<String, dynamic> json) {
    return ServiceCollege(
      id: json['_id'] ?? json['id'],
      degreeId: json['degreeId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      iconName: json['iconName'] ?? 'school',
      description: json['description'] ?? '',
      type: json['type'] ?? 'Government',
      admissionDeadline: json['admissionDeadline'] ?? '',
      duration: json['duration'] ?? 36,
      order: json['order'] ?? 0,
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'degreeId': degreeId,
      'categoryId': categoryId,
      'name': name,
      'state': state,
      'city': city,
      'iconName': iconName,
      'description': description,
      'type': type,
      'admissionDeadline': admissionDeadline,
      'duration': duration,
      'order': order,
      'isActive': isActive,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  ServiceCollege copyWith({
    String? id,
    String? degreeId,
    String? categoryId,
    String? name,
    String? state,
    String? city,
    String? iconName,
    String? description,
    String? type,
    String? admissionDeadline,
    int? duration,
    int? order,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceCollege(
      id: id ?? this.id,
      degreeId: degreeId ?? this.degreeId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      state: state ?? this.state,
      city: city ?? this.city,
      iconName: iconName ?? this.iconName,
      description: description ?? this.description,
      type: type ?? this.type,
      admissionDeadline: admissionDeadline ?? this.admissionDeadline,
      duration: duration ?? this.duration,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
