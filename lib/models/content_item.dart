// Model for content that admins can manage
class ContentItem {
  final String? id;
  final String title;
  final String description;
  final String category; // 'service', 'blog', 'event', etc.
  final String? imageUrl;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;

  ContentItem({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
    this.isPublished = true,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'isPublished': isPublished,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String?,
      isPublished: json['isPublished'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  ContentItem copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? imageUrl,
    bool? isPublished,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContentItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      isPublished: isPublished ?? this.isPublished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
