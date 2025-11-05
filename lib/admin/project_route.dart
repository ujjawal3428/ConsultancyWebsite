// Create a wrapper widget for protected routes
import 'package:consultancy_website/admin/admin_service.dart';
import 'package:flutter/material.dart';

class AdminRoute extends StatelessWidget {
  final Widget child;
  final String? requiredPermission;

  const AdminRoute({super.key, required this.child, this.requiredPermission});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAccess(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.data == true) {
          return child;
        }

        return Scaffold(
          body: Center(
            child: Text('Access Denied'),
          ),
        );
      },
    );
  }

  Future<bool> _checkAccess() async {
    final adminService = AdminService('current_user_id');
    if (requiredPermission != null) {
      return await adminService.hasPermission(requiredPermission!);
    }
    return await adminService.isAdmin();
  }
}