import 'package:flutter/material.dart';
import '../models/service_category.dart';
import '../models/service_degree.dart';
import '../models/service_college.dart';
import '../services/service_management_service.dart';
import '../models/college.dart';

/// Utility to migrate existing static data to Firestore
class MigrateServicesData {
  final ServiceManagementService _service = ServiceManagementService();

  Future<void> migrateAll() async {
    print('Starting migration...');

    try {
      // Step 1: Migrate categories
      print('Migrating categories...');
      final categoryIds = await _migrateCategories();
      print('Categories migrated: ${categoryIds.length}');

      // Step 2: Migrate degrees
      print('Migrating degrees...');
      final degreeIds = await _migrateDegrees(categoryIds);
      print('Degrees migrated: ${degreeIds.length}');

      // Step 3: Migrate colleges
      print('Migrating colleges...');
      await _migrateColleges(categoryIds, degreeIds);
      print('Colleges migrated successfully');

      print('Migration completed successfully!');
    } catch (e) {
      print('Migration failed: $e');
      rethrow;
    }
  }

  Future<Map<String, String>> _migrateCategories() async {
    final Map<String, String> categoryIds = {};

    for (var entry in CategoryConfig.config.entries) {
      final key = entry.key;
      final config = entry.value;

      final category = ServiceCategory(
        key: key,
        title: config['title'] as String,
        iconName: _getIconName(config['icon'] as IconData),
        colorHex: _getColorHex(config['color'] as Color),
        order: _getCategoryOrder(key),
      );

      final id = await _service.createCategory(category);
      categoryIds[key] = id;
      print('Created category: ${category.title} (ID: $id)');
    }

    return categoryIds;
  }

  Future<Map<String, Map<String, String>>> _migrateDegrees(
    Map<String, String> categoryIds,
  ) async {
    final Map<String, Map<String, String>> degreeIds = {};

    for (var categoryEntry in CollegeData.data.entries) {
      final categoryKey = categoryEntry.key;
      final categoryId = categoryIds[categoryKey];

      if (categoryId == null) continue;

      degreeIds[categoryKey] = {};
      int order = 0;

      for (var degreeEntry in categoryEntry.value.entries) {
        final degreeName = degreeEntry.key;

        final degree = ServiceDegree(
          categoryId: categoryId,
          name: degreeName,
          description: 'Degree in $degreeName',
          order: order++,
        );

        final id = await _service.createDegree(degree);
        degreeIds[categoryKey]![degreeName] = id;
        print('Created degree: $degreeName (ID: $id)');
      }
    }

    return degreeIds;
  }

  Future<void> _migrateColleges(
    Map<String, String> categoryIds,
    Map<String, Map<String, String>> degreeIds,
  ) async {
    int order = 0;

    for (var categoryEntry in CollegeData.data.entries) {
      final categoryKey = categoryEntry.key;
      final categoryId = categoryIds[categoryKey];

      if (categoryId == null) continue;

      for (var degreeEntry in categoryEntry.value.entries) {
        final degreeName = degreeEntry.key;
        final degreeId = degreeIds[categoryKey]?[degreeName];

        if (degreeId == null) continue;

        for (var college in degreeEntry.value) {
          final serviceCollege = ServiceCollege(
            categoryId: categoryId,
            degreeId: degreeId,
            name: college.name,
            state: college.state,
            city: college.city,
            iconName: _getIconName(college.logo),
            description: college.description,
            type: college.type,
            admissionDeadline: college.admissionDeadline,
            duration: college.duration,
            order: order++,
          );

          final id = await _service.createCollege(serviceCollege);
          print('Created college: ${college.name} (ID: $id)');
        }
      }
    }
  }

  String _getIconName(IconData icon) {
    // Map IconData to string names
    if (icon == Icons.local_hospital) return 'local_hospital';
    if (icon == Icons.engineering) return 'engineering';
    if (icon == Icons.attach_money) return 'attach_money';
    if (icon == Icons.gavel) return 'gavel';
    if (icon == Icons.business_center) return 'business_center';
    if (icon == Icons.computer) return 'computer';
    if (icon == Icons.school) return 'school';
    if (icon == Icons.science) return 'science';
    if (icon == Icons.medical_services) return 'medical_services';
    return 'school';
  }

  String _getColorHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  }

  int _getCategoryOrder(String key) {
    final order = {
      'medical': 0,
      'engineering': 1,
      'commerce': 2,
      'law': 3,
      'mba': 4,
      'bca': 5,
      'arts': 6,
      'science': 7,
    };
    return order[key] ?? 99;
  }
}

/// Widget to trigger migration from UI
class MigrationButton extends StatefulWidget {
  const MigrationButton({super.key});

  @override
  State<MigrationButton> createState() => _MigrationButtonState();
}

class _MigrationButtonState extends State<MigrationButton> {
  bool _isMigrating = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isMigrating ? null : _runMigration,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEF4444),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      child: _isMigrating
          ? const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 12),
                Text('Migrating...'),
              ],
            )
          : const Text('Migrate Static Data to Firestore'),
    );
  }

  Future<void> _runMigration() async {
    setState(() => _isMigrating = true);

    try {
      final migrator = MigrateServicesData();
      await migrator.migrateAll();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Migration completed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Migration failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isMigrating = false);
      }
    }
  }
}
