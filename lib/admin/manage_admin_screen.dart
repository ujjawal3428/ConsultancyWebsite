import 'package:consultancy_website/admin/admin_service.dart';
import 'package:consultancy_website/models/admin_permission.dart';
import 'package:consultancy_website/models/admin_user.dart';
import 'package:flutter/material.dart';

class ManageAdminsScreen extends StatefulWidget {
  const ManageAdminsScreen({super.key});

  @override
  _ManageAdminsScreenState createState() => _ManageAdminsScreenState();
}

class _ManageAdminsScreenState extends State<ManageAdminsScreen> {
  late AdminService _adminService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Admins'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddAdminDialog(),
          ),
        ],
      ),
      body: StreamBuilder<List<AdminUser>>(
        stream: _adminService.getAllAdmins(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final admins = snapshot.data!;
          return ListView.builder(
            itemCount: admins.length,
            itemBuilder: (context, index) {
              final admin = admins[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(admin.email[0].toUpperCase()),
                ),
                title: Text(admin.email),
                subtitle: Text('Role: ${admin.role}'),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit Permissions'),
                    ),
                    PopupMenuItem(
                      value: 'revoke',
                      child: Text('Revoke Access'),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditPermissionsDialog(admin);
                    } else if (value == 'revoke') {
                      _revokeAccess(admin.id);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showAddAdminDialog() async {
    final emailController = TextEditingController();
    String selectedRole = 'moderator';
    List<String> selectedPermissions = [];

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Add New Admin'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedRole,
                  decoration: InputDecoration(labelText: 'Role'),
                  items: ['super_admin', 'moderator', 'editor']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedRole = value!);
                  },
                ),
                SizedBox(height: 16),
                Text('Permissions:'),
                ...AdminPermission.getAllPermissions().map((permission) {
                  return CheckboxListTile(
                    title: Text(permission),
                    value: selectedPermissions.contains(permission),
                    onChanged: (checked) {
                      setState(() {
                        if (checked!) {
                          selectedPermissions.add(permission);
                        } else {
                          selectedPermissions.remove(permission);
                        }
                      });
                    },
                  );
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _adminService.grantAdminAccess(
                    userId: 'generated_user_id', // Get from auth
                    email: emailController.text,
                    role: selectedRole,
                    permissions: selectedPermissions,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Admin access granted')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showEditPermissionsDialog(AdminUser admin) {}
  
  void _revokeAccess(String id) {}
}