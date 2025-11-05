// screens/admin_panel_screen.dart
import 'package:consultancy_website/admin/admin_service.dart';
import 'package:consultancy_website/admin/manage_admin_screen.dart';
import 'package:flutter/material.dart';
import '../models/admin_user.dart';
import '../models/admin_permission.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  late AdminService _adminService;
  AdminUser? _currentAdmin;

  @override
  void initState() {
    super.initState();
    _loadCurrentAdmin();
  }

  Future<void> _loadCurrentAdmin() async {
    final admin = await _adminService.getCurrentAdminUser();
    setState(() {
      _currentAdmin = admin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentAdmin == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
       title: Text('Admin Panel - Role: ${_currentAdmin!.role}'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: [
          if (_currentAdmin!.hasPermission(AdminPermission.manageUsers))
            _buildAdminCard(
              'Manage Admins',
              Icons.admin_panel_settings,
              () => Navigator.push(context, 
                MaterialPageRoute(builder: (_) => ManageAdminsScreen())),
            ),
          if (_currentAdmin!.hasPermission(AdminPermission.editContent))
            _buildAdminCard(
              'Manage Content',
              Icons.edit,
              () => _navigateToContentManagement(),
            ),
          if (_currentAdmin!.hasPermission(AdminPermission.viewAnalytics))
            _buildAdminCard(
              'Analytics',
              Icons.analytics,
              () => _navigateToAnalytics(),
            ),
          // Add more cards based on permissions
        ],
      ),
    );
  }

  Widget _buildAdminCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
  
  void _navigateToContentManagement() {}
  
  void _navigateToAnalytics() {}
}