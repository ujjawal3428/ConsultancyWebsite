// services/admin_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy_website/models/admin_permission.dart';
import '../models/admin_user.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _currentUserId; // Get from auth

  AdminService(this._currentUserId);

  // Check if current user is admin
  Future<bool> isAdmin() async {
    try {
      final doc = await _firestore.collection('admins').doc(_currentUserId).get();
      return doc.exists && doc.data()?['isActive'] == true;
    } catch (e) {
      return false;
    }
  }

  // Get current admin user
  Future<AdminUser?> getCurrentAdminUser() async {
    try {
      final doc = await _firestore.collection('admins').doc(_currentUserId).get();
      if (doc.exists) {
        return AdminUser.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Check specific permission
  Future<bool> hasPermission(String permission) async {
    final admin = await getCurrentAdminUser();
    return admin?.hasPermission(permission) ?? false;
  }

  // Grant admin access to a user
  Future<void> grantAdminAccess({
    required String userId,
    required String email,
    required String role,
    required List<String> permissions,
  }) async {
    // Only super_admin can grant access
    if (!await hasPermission(AdminPermission.manageUsers)) {
      throw Exception('Insufficient permissions');
    }

    await _firestore.collection('admins').doc(userId).set({
      'email': email,
      'role': role,
      'permissions': permissions,
      'isActive': true,
      'createdBy': _currentUserId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update admin permissions
  Future<void> updateAdminPermissions({
    required String adminId,
    required List<String> permissions,
  }) async {
    if (!await hasPermission(AdminPermission.manageUsers)) {
      throw Exception('Insufficient permissions');
    }

    await _firestore.collection('admins').doc(adminId).update({
      'permissions': permissions,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Revoke admin access
  Future<void> revokeAdminAccess(String adminId) async {
    if (!await hasPermission(AdminPermission.manageUsers)) {
      throw Exception('Insufficient permissions');
    }

    await _firestore.collection('admins').doc(adminId).update({
      'isActive': false,
      'revokedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get all admins
  Stream<List<AdminUser>> getAllAdmins() {
    return _firestore
        .collection('admins')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AdminUser.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }
}