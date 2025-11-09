import 'package:flutter/material.dart';
import '../models/service_category.dart';
import '../models/service_degree.dart';
import '../services/service_management_service.dart';

class ServiceDegreeFormScreen extends StatefulWidget {
  final ServiceDegree? degree;

  const ServiceDegreeFormScreen({super.key, this.degree});

  @override
  State<ServiceDegreeFormScreen> createState() =>
      _ServiceDegreeFormScreenState();
}

class _ServiceDegreeFormScreenState extends State<ServiceDegreeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ServiceManagementService _service = ServiceManagementService();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _orderController;
  String? _selectedCategoryId;
  bool _isActive = true;
  bool _isLoading = false;
  List<ServiceCategory> _categories = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.degree?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.degree?.description ?? '',
    );
    _orderController = TextEditingController(
      text: widget.degree?.order.toString() ?? '0',
    );
    _selectedCategoryId = widget.degree?.categoryId;
    _isActive = widget.degree?.isActive ?? true;
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _service.getActiveCategories();
      setState(() {
        _categories = categories;
        if (_selectedCategoryId == null && categories.isNotEmpty) {
          _selectedCategoryId = categories.first.id;
        }
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.degree == null ? 'Add Degree' : 'Edit Degree'),
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
                      value: _selectedCategoryId,
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
                        setState(() => _selectedCategoryId = value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Degree Name',
                        hintText: 'e.g., MBBS, B.Tech, MBA',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a degree name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description (Optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
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
                      activeColor: const Color(0xFFEF4444),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveDegree,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        widget.degree == null
                            ? 'Create Degree'
                            : 'Update Degree',
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _saveDegree() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final degree = ServiceDegree(
        id: widget.degree?.id,
        categoryId: _selectedCategoryId!,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        order: int.parse(_orderController.text),
        isActive: _isActive,
        createdAt: widget.degree?.createdAt,
      );

      if (widget.degree == null) {
        await _service.createDegree(degree);
      } else {
        await _service.updateDegree(widget.degree!.id!, degree);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.degree == null
                  ? 'Degree created successfully'
                  : 'Degree updated successfully',
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
