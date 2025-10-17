import 'package:flutter/material.dart';

class ServicesMenu extends StatelessWidget {
  const ServicesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // fixed width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top red strip
            Container(
              height: 5,
              width: double.infinity,
              color: Colors.red,
            ),
        
            // For Students & Parents section
            _buildSectionHeader("For Students & Parents"),
            Column(
              children: [
                _buildMenuItem(context, "Undergraduate Preparation"),
                _buildMenuItem(context, "Undergraduate Admissions"),
                _buildMenuItem(context, "Boarding School Admissions"),
                _buildMenuItem(context, "Postgraduate Admissions"),
                _buildMenuItem(context, "MBA Admissions"),
                _buildMenuItem(context, "Education Counselling"),
                _buildMenuItem(context, "INK | Interactive Narrative Kit"),
                _buildMenuItem(context, "Visa Services"),
              ],
            ),
        
            // For Institutions section
            _buildSectionHeader("For Institutions"),
            Column(
              children: [
                _buildMenuItem(context, "Undergraduate Admissions"),
                _buildMenuItem(context, "Counselling for Schools"),
                _buildMenuItem(context, "Postgraduate Admissions"),
                _buildMenuItem(context, "Counselling for Colleges"),
              ],
            ),
        
            // Bottom red strip
            Container(
              height: 5,
              width: double.infinity,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        border: Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title) {
    return _HoverText(
      title: title,
      onTap: () => _navigateToService(context, title),
    );
  }

  void _navigateToService(BuildContext context, String serviceName) {
    // Map service names to their routes
    final routes = {
      'Undergraduate Preparation': '/undergraduate-preparation',
      'Undergraduate Admissions': '/undergraduate-admissions',
      'Boarding School Admissions': '/boarding-school-admissions',
      'Postgraduate Admissions': '/postgraduate-admissions',
      'MBA Admissions': '/mba-admissions',
      'Education Counselling': '/education-counselling',
      'INK | Interactive Narrative Kit': '/ink-interactive-narrative-kit',
      'Visa Services': '/visa-services',
      'Counselling for Schools': '/counselling-schools',
      'Counselling for Colleges': '/counselling-colleges',
    };

    final route = routes[serviceName];
   if (route != null) {
  Navigator.pop(context); // 👈 closes dropdown overlay or dialog
  Future.delayed(const Duration(milliseconds: 150), () {
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, route);
  });
   }}

  /// Mobile version menu items
  static List<Widget> getMobileMenuItems(BuildContext context) {
    final studentServices = [
      'Undergraduate Preparation',
      'Undergraduate Admissions',
      'Boarding School Admissions',
      'Postgraduate Admissions',
      'MBA Admissions',
      'Education Counselling',
      'INK | Interactive Narrative Kit',
      'Visa Services',
    ];

    final institutionServices = [
      'Undergraduate Admissions',
      'Counselling for Schools',
      'Postgraduate Admissions',
      'Counselling for Colleges',
    ];

    List<Widget> allItems = [];
    
    // Student Services Header
    allItems.add(
      Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAFB),
          border: Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
            bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'For Students & Parents',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
    
    // Student Services Items
    allItems.addAll(
      studentServices.map((service) => _buildMobileMenuItem(context, service)),
    );

    // Institution Services Header
    allItems.add(
      Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAFB),
          border: Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
            bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'For Institutions',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
    
    // Institution Services Items
    allItems.addAll(
      institutionServices.map((service) => _buildMobileMenuItem(context, service)),
    );

    return allItems;
  }

  static Widget _buildMobileMenuItem(BuildContext context, String service) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => (context, service),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  service,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Hover text widget
class _HoverText extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  
  const _HoverText({
    required this.title,
    required this.onTap,
  });

  @override
  State<_HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<_HoverText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
  cursor: SystemMouseCursors.click, 
  onEnter: (_) => setState(() => _isHovering = true),
  onExit: (_) => setState(() => _isHovering = false),
  child: GestureDetector(
    onTap: widget.onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _isHovering ? Colors.red : const Color(0xFF374151),
        ),
      ),
    ),
  ),
);

  }
}