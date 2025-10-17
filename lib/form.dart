import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String? _selectedTitle;
  String? _selectedHelp;
  String? _selectedFillingPerson;
  String _selectedCountryCode = '+91';

  final List<String> _titles = ['Mr.', 'Mrs.', 'Ms.', 'Dr.'];
  final List<String> _helpOptions = [
    'Undergraduate/Postgraduate/MBA admissions',
    'Education Counselling',
    'Other Inquiries'
  ];
  final List<String> _fillingPersonOptions = [
    'Self',
    'Family Member',
    'Friend',
    'Corporate/Organization',
    'Other'
  ];
  final List<String> _countryCodes = ['+91', '+1', '+44', '+61'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmall ? 16 : 40,
        vertical: isSmall ? 20 : 40,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 550),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha : 0.15),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context, isSmall),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isSmall ? 24 : 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHelpDropdown(),
                      const SizedBox(height: 24),
                      _buildNameSection(isSmall),
                      const SizedBox(height: 24),
                      _buildEmailField(),
                      const SizedBox(height: 24),
                      _buildPhoneField(isSmall),
                      const SizedBox(height: 24),
                      _buildFillingPersonDropdown(),
                      const SizedBox(height: 32),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 20 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade600, Colors.red.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha : 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.event_note, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book an Appointment',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'We\'ll get back to you shortly',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha : 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 22),
              onPressed: () => Navigator.of(context).pop(),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('How can we help you?', true),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: _selectedHelp,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              hintText: 'Select your inquiry type',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
              prefixIcon: Icon(Icons.help_outline, color: Colors.red[600], size: 22),
            ),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.red[600], size: 28),
            isExpanded: true,
            dropdownColor: Colors.white,
            items: _helpOptions.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option, style: const TextStyle(fontSize: 15)),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedHelp = value),
            validator: (value) => value == null ? 'Please select an option' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildNameSection(bool isSmall) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Full Name', true),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: _buildTitleDropdown(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _firstNameController,
                hint: 'First Name',
                icon: Icons.person_outline,
                isRequired: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _lastNameController,
          hint: 'Last Name',
          icon: Icons.person_outline,
          isRequired: true,
        ),
      ],
    );
  }

  Widget _buildTitleDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedTitle,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(fontSize: 14),
        ),
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.red[600], size: 22),
        dropdownColor: Colors.white,
        items: _titles.map((title) {
          return DropdownMenuItem(
            value: title,
            child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          );
        }).toList(),
        onChanged: (value) => setState(() => _selectedTitle = value),
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isRequired = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
          prefixIcon: Icon(icon, color: Colors.red[600], size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        validator: (value) => isRequired && (value == null || value.isEmpty) 
            ? 'This field is required' 
            : null,
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Email Address', true),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'your.email@example.com',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
              prefixIcon: Icon(Icons.email_outlined, color: Colors.red[600], size: 22),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(bool isSmall) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Phone Number', true),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                initialValue: _selectedCountryCode,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  border: InputBorder.none,
                ),
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.red[600], size: 22),
                dropdownColor: Colors.white,
                items: _countryCodes.map((code) {
                  return DropdownMenuItem(
                    value: code,
                    child: Text(
                      code,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCountryCode = value!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    prefixIcon: Icon(Icons.phone_outlined, color: Colors.red[600], size: 22),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  validator: (value) => value == null || value.isEmpty 
                      ? 'Phone number is required' 
                      : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFillingPersonDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Who is filling this form?', true),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: _selectedFillingPerson,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              hintText: 'Select an option',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
              prefixIcon: Icon(Icons.people_outline, color: Colors.red[600], size: 22),
            ),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.red[600], size: 28),
            isExpanded: true,
            dropdownColor: Colors.white,
            items: _fillingPersonOptions.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option, style: const TextStyle(fontSize: 15)),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedFillingPerson = value),
            validator: (value) => value == null ? 'Please select an option' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String label, bool isRequired) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1a1a1a),
          ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade600, Colors.red.shade700],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha : 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Appointment booked successfully!',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Book Appointment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}