class AdminUser {
  final String id;
  final String email;
  final String role;
  final List<String> permissions;
  final bool isActive;

  AdminUser({
    required this.id,
    required this.email,
    required this.role,
    required this.permissions,
    this.isActive = true,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      permissions: List<String>.from(json['permissions'] ?? []),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'permissions': permissions,
      'isActive': isActive,
    };
  }

  bool hasPermission(String permission) {
    return permissions.contains(permission) || role == 'super_admin';
  }
}