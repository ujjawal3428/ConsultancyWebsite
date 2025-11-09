import 'package:flutter/material.dart';
import '../models/service_category.dart';
import '../models/service_degree.dart';
import '../models/service_college.dart';
import '../services/service_management_service.dart';
import '../utils/migrate_services_data.dart';
import 'service_category_form_screen.dart';
import 'service_degree_form_screen.dart';
import 'service_college_form_screen.dart';

class ManageServicesScreen extends StatefulWidget {
  const ManageServicesScreen({super.key});

  @override
  State<ManageServicesScreen> createState() => _ManageServicesScreenState();
}

class _ManageServicesScreenState extends State<ManageServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ServiceManagementService _service = ServiceManagementService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Services'),
        backgroundColor: const Color(0xFFEF4444),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Categories'),
            Tab(text: 'Degrees'),
            Tab(text: 'Colleges'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCategoriesTab(),
          _buildDegreesTab(),
          _buildCollegesTab(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _navigateToAddCategory(),
                icon: const Icon(Icons.add),
                label: const Text('Add Category'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              const MigrationButton(),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<ServiceCategory>>(
            future: _service.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final categories = snapshot.data ?? [];

              if (categories.isEmpty) {
                return const Center(child: Text('No categories found'));
              }

              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: category.getColor().withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          category.getIcon(),
                          color: category.getColor(),
                        ),
                      ),
                      title: Text(category.title),
                      subtitle: Text(
                        'Key: ${category.key} | Order: ${category.order}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _navigateToEditCategory(category),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteCategory(category.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDegreesTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () => _navigateToAddDegree(),
            icon: const Icon(Icons.add),
            label: const Text('Add Degree'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<ServiceDegree>>(
            future: _service.getDegrees(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final degrees = snapshot.data ?? [];

              if (degrees.isEmpty) {
                return const Center(child: Text('No degrees found'));
              }

              return ListView.builder(
                itemCount: degrees.length,
                itemBuilder: (context, index) {
                  final degree = degrees[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.school,
                        color: Color(0xFFEF4444),
                      ),
                      title: Text(degree.name),
                      subtitle: Text(
                        'Category ID: ${degree.categoryId} | Order: ${degree.order}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _navigateToEditDegree(degree),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteDegree(degree.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCollegesTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () => _navigateToAddCollege(),
            icon: const Icon(Icons.add),
            label: const Text('Add College'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<ServiceCollege>>(
            future: _service.getColleges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final colleges = snapshot.data ?? [];

              if (colleges.isEmpty) {
                return const Center(child: Text('No colleges found'));
              }

              return ListView.builder(
                itemCount: colleges.length,
                itemBuilder: (context, index) {
                  final college = colleges[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(college.name),
                      subtitle: Text(
                        '${college.city}, ${college.state} | ${college.type}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _navigateToEditCollege(college),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteCollege(college.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToAddCategory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ServiceCategoryFormScreen(),
      ),
    );
  }

  void _navigateToEditCategory(ServiceCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceCategoryFormScreen(category: category),
      ),
    );
  }

  void _navigateToAddDegree() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ServiceDegreeFormScreen()),
    );
  }

  void _navigateToEditDegree(ServiceDegree degree) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceDegreeFormScreen(degree: degree),
      ),
    );
  }

  void _navigateToAddCollege() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ServiceCollegeFormScreen()),
    );
  }

  void _navigateToEditCollege(ServiceCollege college) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceCollegeFormScreen(college: college),
      ),
    );
  }

  Future<void> _deleteCategory(String id) async {
    final confirm = await _showDeleteConfirmation('category');
    if (confirm == true) {
      try {
        await _service.deleteCategory(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting category: $e')),
          );
        }
      }
    }
  }

  Future<void> _deleteDegree(String id) async {
    final confirm = await _showDeleteConfirmation('degree');
    if (confirm == true) {
      try {
        await _service.deleteDegree(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Degree deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error deleting degree: $e')));
        }
      }
    }
  }

  Future<void> _deleteCollege(String id) async {
    final confirm = await _showDeleteConfirmation('college');
    if (confirm == true) {
      try {
        await _service.deleteCollege(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('College deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error deleting college: $e')));
        }
      }
    }
  }

  Future<bool?> _showDeleteConfirmation(String itemType) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete $itemType?'),
        content: Text('Are you sure you want to delete this $itemType?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
