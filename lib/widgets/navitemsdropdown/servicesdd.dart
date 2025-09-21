import 'package:flutter/material.dart';

class ServicesMenu extends StatelessWidget {
  const ServicesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // No extra padding/margin
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000), // ✅ FIXED: Direct ARGB value instead of withOpacity
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🔴 Top strip
          Container(
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: _buildServiceCategories(),
            ),
          ),

          // 🔴 Bottom strip
          Container(
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCategories() {
    return Column(
      children: [
        _buildServiceCategory(
          [
            {'title': 'Undergraduate Preparation', 'icon': Icons.school_rounded},
            {'title': 'Undergraduate Admissions', 'icon': Icons.account_balance_rounded},
            {'title': 'Boarding School Admissions', 'icon': Icons.home_rounded},
            {'title': 'Postgraduate Admissions', 'icon': Icons.psychology_rounded},
            {'title': 'MBA Admissions', 'icon': Icons.business_center_rounded},
            {'title': 'Education Counselling', 'icon': Icons.support_agent_rounded},
            {'title': 'INK | Interactive Narrative Kit', 'icon': Icons.auto_stories_rounded},
            {'title': 'Visa Services', 'icon': Icons.flight_takeoff_rounded},
          ],
        ),
        _buildServiceCategory(
          [
            {'title': 'Undergraduate Admissions', 'icon': Icons.school_rounded},
            {'title': 'Counselling for Schools', 'icon': Icons.domain_rounded},
            {'title': 'Postgraduate Admissions', 'icon': Icons.psychology_rounded},
            {'title': 'Counselling for Colleges', 'icon': Icons.corporate_fare_rounded},
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCategory(List<Map<String, dynamic>> services) {
    return Column(
      children: services.asMap().entries.map((entry) {
        final isLast = entry.key == services.length - 1;
        return _buildServiceItem(
          entry.value['title'] as String,
          entry.value['icon'] as IconData,
          isLast,
        );
      }).toList(),
    );
  }

  Widget _buildServiceItem(String title, IconData icon, bool isLast) {
    return StatefulBuilder(
      builder: (context, setState) {

        return InkWell(
          onTap: () => print('Tapped on: $title'),
          borderRadius: isLast
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )
              : BorderRadius.zero,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: !isLast
                  ? const Border(
                      bottom: BorderSide(
                        color: Color(0xFFF3F4F6),
                        width: 1,
                      ),
                    )
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color:Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ✅ Mobile version with fixed opacity colors
  static List<Widget> getMobileMenuItems() {
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0x26F44336), // ✅ FIXED: Direct ARGB value for red with 15% opacity
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'For Students & Parents',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ),
    );

    // Student Services Items
    allItems.addAll(
      studentServices.map((service) => ListTile(
            title: Text(
              service,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: Colors.red,
            ),
            onTap: () {
              print('Mobile tapped: $service');
            },
          )),
    );

    // Institution Services Header
    allItems.add(
      Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0x26F44336), // ✅ FIXED: Direct ARGB value for red with 15% opacity
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'For Institutions',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ),
    );

    // Institution Services Items
    allItems.addAll(
      institutionServices.map((service) => ListTile(
            title: Text(
              service,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: Colors.red,
            ),
            onTap: () {
              print('Mobile tapped: $service');
            },
          )),
    );

    return allItems;
  }
}