import 'package:flutter/material.dart';

/// Model for service categories (Medical, Engineering, etc.)
class ServiceCategory {
  final String? id;
  final String key; // 'medical', 'engineering', etc.
  final String title; // 'Medical', 'Engineering', etc.
  final String iconName; // Icon name as string
  final String colorHex; // Color as hex string
  final int order; // Display order
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServiceCategory({
    this.id,
    required this.key,
    required this.title,
    required this.iconName,
    required this.colorHex,
    this.order = 0,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['_id'] ?? json['id'],
      key: json['key'] ?? '',
      title: json['title'] ?? '',
      iconName: json['iconName'] ?? 'business_center',
      colorHex: json['colorHex'] ?? '#EF4444',
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
      if (id != null) '_id': id,
      'key': key,
      'title': title,
      'iconName': iconName,
      'colorHex': colorHex,
      'order': order,
      'isActive': isActive,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  IconData getIcon() {
    // Map icon names to IconData
    final iconMap = {
      'local_hospital': Icons.local_hospital,
      'engineering': Icons.engineering,
      'attach_money': Icons.attach_money,
      'gavel': Icons.gavel,
      'business_center': Icons.business_center,
      'computer': Icons.computer,
      'school': Icons.school,
      'science': Icons.science,
      'medical_services': Icons.medical_services,
    };
    return iconMap[iconName] ?? Icons.business_center;
  }

  Color getColor() {
    return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
  }

  ServiceCategory copyWith({
    String? id,
    String? key,
    String? title,
    String? iconName,
    String? colorHex,
    int? order,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceCategory(
      id: id ?? this.id,
      key: key ?? this.key,
      title: title ?? this.title,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
