import 'package:flutter/material.dart';
import '../models/service_category.dart';
import '../models/service_degree.dart';
import '../models/service_college.dart';
import '../services/service_management_service.dart';

class ServiceCollegeFormScreen extends StatefulWidget {
  final ServiceCollege? college;

  const ServiceCollegeFormScreen({super.key, this.college});

  @override
  State<ServiceCollegeFormScreen> createState() =>
      _ServiceCollegeFormScreenState();
}

class _ServiceCollegeFormScreenState extends State<ServiceCollegeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ServiceManagementService _service = ServiceManagementService();

  late TextEditingController _nameController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _descriptionController;
  late TextEditingController _admissionDeadlineController;
  late TextEditingController _durationController;
  late TextEditingController _orderController;

  String? _selectedCategoryId;
  String? _selectedDegreeId;
  String _selectedIcon = 'school';
  String _selectedType = 'Government';
  bool _isActive = true;
  bool _isLoading = false;

  List<ServiceCategory> _categories = [];
  List<ServiceDegree> _degrees = [];

  final List<Map<String, dynamic>> _availableIcons = [
    {'name': 'school', 'icon': Icons.school},
    {'name': 'local_hospital', 'icon': Icons.local_hospital},
    {'name': 'engineering', 'icon': Icons.engineering},
    {'name': 'computer', 'icon': Icons.computer},
    {'name': 'business_center', 'icon': Icons.business_center},
    {'name': 'science', 'icon': Icons.science},
    {'name': 'gavel', 'icon': Icons.gavel},
    {'name': 'medical_services', 'icon': Icons.medical_services},
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.college?.name ?? '');
    _stateController = TextEditingController(text: widget.college?.state ?? '');
    _cityController = TextEditingController(text: widget.college?.city ?? '');
    _descriptionController = TextEditingController(
      text: widget.college?.description ?? '',
    );
    _admissionDeadlineController = TextEditingController(
      text: widget.college?.admissionDeadline ?? '',
    );
    _durationController = TextEditingController(
      text: widget.college?.duration.toString() ?? '36',
    );
    _orderController = TextEditingController(
      text: widget.college?.order.toString() ?? '0',
    );

    _selectedCategoryId = widget.college?.categoryId;
    _selectedDegreeId = widget.college?.degreeId;
    _selectedIcon = widget.college?.iconName ?? 'school';
    _selectedType = widget.college?.type ?? 'Government';
    _isActive = widget.college?.isActive ?? true;

    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _service.getActiveCategories();
      setState(() {
        _categories = categories;
        if (_selectedCategoryId == null && categories.isNotEmpty) {
          _selectedCategoryId = categories.first.id;
          _loadDegrees(_selectedCategoryId!);
        } else if (_selectedCategoryId != null) {
          _loadDegrees(_selectedCategoryId!);
        }
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> _loadDegrees(String categoryId) async {
    try {
      final degrees = await _service.getDegreesByCategory(categoryId);
      setState(() {
        _degrees = degrees;
        if (_selectedDegreeId == null && degrees.isNotEmpty) {
          _selectedDegreeId = degrees.first.id;
        }
      });
    } catch (e) {
      print('Error loading degrees: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    _admissionDeadlineController.dispose();
    _durationController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.college == null ? 'Add College' : 'Edit College'),
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
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCategoryId,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category.id,
                          child: Text(category.title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                          _selectedDegreeId = null;
                          if (value != null) {
                            _loadDegrees(value);
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDegreeId,
                      decoration: const InputDecoration(
                        labelText: 'Degree',
                        border: OutlineInputBorder(),
                      ),
                      items: _degrees.map((degree) {
                        return DropdownMenuItem(
                          value: degree.id,
                          child: Text(degree.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedDegreeId = value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a degree';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'College Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter college name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cityController,
                            decoration: const InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _stateController,
                            decoration: const InputDecoration(
                              labelText: 'State',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Government', 'Private'].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedType = value!);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _admissionDeadlineController,
                      decoration: const InputDecoration(
                        labelText: 'Admission Deadline',
                        hintText: 'e.g., 31-DEC-2025',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter deadline';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _durationController,
                      decoration: const InputDecoration(
                        labelText: 'Duration (in months)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter duration';
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
                    SwitchListTile(
                      title: const Text('Active'),
                      value: _isActive,
                      onChanged: (value) => setState(() => _isActive = value),
                      activeThumbColor: const Color(0xFFEF4444),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveCollege,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        widget.college == null
                            ? 'Create College'
                            : 'Update College',
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _saveCollege() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final college = ServiceCollege(
        id: widget.college?.id,
        categoryId: _selectedCategoryId!,
        degreeId: _selectedDegreeId!,
        name: _nameController.text.trim(),
        state: _stateController.text.trim(),
        city: _cityController.text.trim(),
        iconName: _selectedIcon,
        description: _descriptionController.text.trim(),
        type: _selectedType,
        admissionDeadline: _admissionDeadlineController.text.trim(),
        duration: int.parse(_durationController.text),
        order: int.parse(_orderController.text),
        isActive: _isActive,
        createdAt: widget.college?.createdAt,
      );

      if (widget.college == null) {
        await _service.createCollege(college);
      } else {
        await _service.updateCollege(widget.college!.id!, college);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.college == null
                  ? 'College created successfully'
                  : 'College updated successfully',
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
