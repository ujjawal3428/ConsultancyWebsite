import 'package:flutter/material.dart';
import '../models/service_category.dart';
import '../services/service_management_service.dart';

class ServiceCategoryFormScreen extends StatefulWidget {
  final ServiceCategory? category;

  const ServiceCategoryFormScreen({super.key, this.category});

  @override
  State<ServiceCategoryFormScreen> createState() =>
      _ServiceCategoryFormScreenState();
}

class _ServiceCategoryFormScreenState extends State<ServiceCategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ServiceManagementService _service = ServiceManagementService();

  late TextEditingController _keyController;
  late TextEditingController _titleController;
  late TextEditingController _orderController;
  String _selectedIcon = 'business_center';
  String _selectedColor = '#EF4444';
  bool _isActive = true;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _availableIcons = [
    {'name': 'business_center', 'icon': Icons.business_center},
    {'name': 'local_hospital', 'icon': Icons.local_hospital},
    {'name': 'engineering', 'icon': Icons.engineering},
    {'name': 'attach_money', 'icon': Icons.attach_money},
    {'name': 'gavel', 'icon': Icons.gavel},
    {'name': 'computer', 'icon': Icons.computer},
    {'name': 'school', 'icon': Icons.school},
    {'name': 'science', 'icon': Icons.science},
    {'name': 'medical_services', 'icon': Icons.medical_services},
  ];

  final List<String> _availableColors = [
    '#EF4444', // Red
    '#3B82F6', // Blue
    '#10B981', // Green
    '#8B5CF6', // Purple
    '#F59E0B', // Amber
    '#06B6D4', // Cyan
    '#6366F1', // Indigo
    '#EC4899', // Pink
  ];

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController(text: widget.category?.key ?? '');
    _titleController = TextEditingController(
      text: widget.category?.title ?? '',
    );
    _orderController = TextEditingController(
      text: widget.category?.order.toString() ?? '0',
    );
    _selectedIcon = widget.category?.iconName ?? 'business_center';
    _selectedColor = widget.category?.colorHex ?? '#EF4444';
    _isActive = widget.category?.isActive ?? true;
  }

  @override
  void dispose() {
    _keyController.dispose();
    _titleController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null ? 'Add Category' : 'Edit Category'),
        backgroundColor: const Color(0xFFEF4444),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _keyController,
                      decoration: const InputDecoration(
                        labelText: 'Key',
                        hintText: 'e.g., medical, engineering',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a key';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        hintText: 'e.g., Medical, Engineering',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _orderController,
                      decoration: const InputDecoration(
                        labelText: 'Display Order',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an order';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select Icon:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableIcons.map((iconData) {
                        final isSelected = _selectedIcon == iconData['name'];
                        return InkWell(
                          onTap: () =>
                              setState(() => _selectedIcon = iconData['name']),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFEF4444)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFEF4444)
                                    : Colors.grey[400]!,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              iconData['icon'],
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select Color:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableColors.map((colorHex) {
                        final isSelected = _selectedColor == colorHex;
                        final color = Color(
                          int.parse(colorHex.replaceFirst('#', '0xFF')),
                        );
                        return InkWell(
                          onTap: () =>
                              setState(() => _selectedColor = colorHex),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey[400]!,
                                width: isSelected ? 3 : 1,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Active'),
                      value: _isActive,
                      onChanged: (value) => setState(() => _isActive = value),
                      activeColor: const Color(0xFFEF4444),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveCategory,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        widget.category == null
                            ? 'Create Category'
                            : 'Update Category',
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final category = ServiceCategory(
        id: widget.category?.id,
        key: _keyController.text.trim(),
        title: _titleController.text.trim(),
        iconName: _selectedIcon,
        colorHex: _selectedColor,
        order: int.parse(_orderController.text),
        isActive: _isActive,
        createdAt: widget.category?.createdAt,
      );

      if (widget.category == null) {
        await _service.createCategory(category);
      } else {
        await _service.updateCategory(widget.category!.id!, category);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.category == null
                  ? 'Category created successfully'
                  : 'Category updated successfully',
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
