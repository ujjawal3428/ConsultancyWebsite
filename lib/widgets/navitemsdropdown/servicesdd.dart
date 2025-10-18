import 'package:consultancy_website/custom_app_bar.dart' show CustomAppBar;
import 'package:consultancy_website/widgets/footer_widget.dart' show FooterSection;
import 'package:flutter/material.dart';

// Models
class College {
  final int id;
  final String name;
  final String state;
  final String city;
  final IconData logo;
  final String description;
  final String type;
  final String admissionDeadline;
  final int duration;

  College({
    required this.id,
    required this.name,
    required this.state,
    required this.city,
    required this.logo,
    required this.description,
    required this.type,
    required this.admissionDeadline,
    required this.duration,
  });
}

class CollegeData {
  static final Map<String, Map<String, List<College>>> data = {
    'medical': {
      'MBBS': [
        College(
          id: 1,
          name: 'All India Institute of Medical Sciences',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.local_hospital,
          description: 'Premier medical institution offering MBBS with world-class facilities.',
          type: 'Government',
          admissionDeadline: '31-OCT-2025',
          duration: 36,
        ),
        College(
          id: 2,
          name: 'Nalanda Medical College',
          state: 'Bihar',
          city: 'Nalanda',
          logo: Icons.local_hospital,
          description: 'Established medical college with strong clinical training programs.',
          type: 'Government',
          admissionDeadline: '15-NOV-2025',
          duration: 36,
        ),
      ],
      'BDS': [
        College(
          id: 3,
          name: 'Bihar Dental College',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.medical_services,
          description: 'State-of-the-art dental college with modern laboratories.',
          type: 'Government',
          admissionDeadline: '30-OCT-2025',
          duration: 24,
        ),
      ],
    },
    'engineering': {
      'B.Tech': [
        College(
          id: 4,
          name: 'National Institute of Technology',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.engineering,
          description: 'Leading engineering institute with industry partnerships.',
          type: 'Government',
          admissionDeadline: '31-DEC-2025',
          duration: 48,
        ),
      ],
    },
    'commerce': {
      'B.Com': [
        College(
          id: 5,
          name: 'Institute of Commerce Studies',
          state: 'Uttar Pradesh',
          city: 'Lucknow',
          logo: Icons.account_balance,
          description: 'Premier commerce college with excellent faculty.',
          type: 'Government',
          admissionDeadline: '20-NOV-2025',
          duration: 36,
        ),
      ],
    },
    'law': {
      'B.Law': [
        College(
          id: 6,
          name: 'National Law University',
          state: 'Uttar Pradesh',
          city: 'Lucknow',
          logo: Icons.gavel,
          description: 'Prestigious law school producing top legal professionals.',
          type: 'Government',
          admissionDeadline: '15-DEC-2025',
          duration: 36,
        ),
      ],
    },
    'mba': {
      'MBA': [
        College(
          id: 7,
          name: 'Institute of Management Studies',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.business_center,
          description: 'Business school with strong placement record.',
          type: 'Private',
          admissionDeadline: '28-FEB-2025',
          duration: 24,
        ),
      ],
    },
    'bca': {
      'BCA': [
        College(
          id: 8,
          name: 'Institute of Technology',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.computer,
          description: 'Computer science college with industry-relevant curriculum.',
          type: 'Private',
          admissionDeadline: '31-JAN-2025',
          duration: 36,
        ),
      ],
    },
    'arts': {
      'B.A': [
        College(
          id: 9,
          name: 'Central Arts College',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.school,
          description: 'Liberal arts institution fostering critical thinking.',
          type: 'Government',
          admissionDeadline: '25-OCT-2025',
          duration: 36,
        ),
      ],
    },
    'science': {
      'B.Sc': [
        College(
          id: 10,
          name: 'Institute of Pure Sciences',
          state: 'Uttar Pradesh',
          city: 'Lucknow',
          logo: Icons.science,
          description: 'Science college with advanced research facilities.',
          type: 'Government',
          admissionDeadline: '30-OCT-2025',
          duration: 36,
        ),
      ],
    },
  };
}

class CategoryConfig {
  static final Map<String, Map<String, dynamic>> config = {
    'medical': {'title': 'Medical', 'icon': Icons.local_hospital, 'color': Color(0xFFEF4444)},
    'engineering': {'title': 'Engineering', 'icon': Icons.engineering, 'color': Color(0xFF3B82F6)},
    'commerce': {'title': 'Commerce', 'icon': Icons.attach_money, 'color': Color(0xFF10B981)},
    'law': {'title': 'Law', 'icon': Icons.gavel, 'color': Color(0xFF8B5CF6)},
    'mba': {'title': 'MBA', 'icon': Icons.business_center, 'color': Color(0xFFF59E0B)},
    'bca': {'title': 'BCA', 'icon': Icons.computer, 'color': Color(0xFF06B6D4)},
    'arts': {'title': 'Arts', 'icon': Icons.school, 'color': Color(0xFF6366F1)},
    'science': {'title': 'Science', 'icon': Icons.science, 'color': Color(0xFFEC4899)},
  };
}

class ServicesMenu extends StatefulWidget {
  const ServicesMenu({super.key});

  @override
  State<ServicesMenu> createState() => _ServicesMenuState();
}

class _ServicesMenuState extends State<ServicesMenu> {
  String? expandedCategory;
  Map<String, bool> expandedDegrees = {};
  College? selectedCollege;
  bool showMobileDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main Content Area - Using constraints instead of Expanded
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 80 - 200, // screen height - appbar - approximate footer
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = MediaQuery.of(context).size.width > 768;
                  
                  return isDesktop
                      ? _buildDesktopLayout()
                      : _buildMobileLayout();
                },
              ),
            ),
            // Footer
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Navigation Panel
          Container(
            width: 300,
            color: const Color(0xFFF9FAFB),
            child: SingleChildScrollView(
              child: _buildNavigationPanel(),
            ),
          ),
          // Divider
          Container(width: 1, color: const Color(0xFFE5E7EB)),
          // Right Details Panel
          Expanded(
            child: Container(
              color: Colors.white,
              child: selectedCollege != null
                  ? SingleChildScrollView(
                      child: _buildCollegeDetails(selectedCollege!),
                    )
                  : _buildEmptyState(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    if (showMobileDetails && selectedCollege != null) {
      return Column(
        children: [
          // Back button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              border: Border(
                bottom: BorderSide(color: Color(0xFFE5E7EB)),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      showMobileDetails = false;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'College Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildCollegeDetails(selectedCollege!),
        ],
      );
    }

    return _buildNavigationPanel();
  }

  Widget _buildNavigationPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Explore Courses',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
        ),
        ...CategoryConfig.config.entries.map((entry) {
          final category = entry.key;
          final config = entry.value;
          final isExpanded = expandedCategory == category;

          return _buildCategoryItem(
            category,
            config,
            isExpanded,
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 80,
              color: Color(0xFFE5E7EB),
            ),
            SizedBox(height: 16),
            Text(
              'Select a college to view details',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    String category,
    Map<String, dynamic> config,
    bool isExpanded,
  ) {
    final color = config['color'] as Color;
    final icon = config['icon'] as IconData;
    final degrees = CollegeData.data[category]?.keys.toList() ?? [];

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expandedCategory = isExpanded ? null : category;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isExpanded ? color : const Color(0xFFE5E7EB),
                width: isExpanded ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    config['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: color,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: degrees.map((degree) {
                final degreeKey = '$category-$degree';
                final isDegreeExpanded = expandedDegrees[degreeKey] ?? false;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expandedDegrees[degreeKey] = !isDegreeExpanded;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha : 0.05),
                          borderRadius: BorderRadius.circular(6),
                          border: Border(
                            left: BorderSide(color: color, width: 3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                degree,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                ),
                              ),
                            ),
                            Icon(
                              isDegreeExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 16,
                              color: color,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isDegreeExpanded)
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 10),
                        child: Column(
                          children: (CollegeData.data[category]?[degree] ?? [])
                              .map((college) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCollege = college;
                                  if (MediaQuery.of(context).size.width <= 768) {
                                    showMobileDetails = true;
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedCollege?.id == college.id
                                      ? color.withValues(alpha : 0.15)
                                      : const Color(0xFFF9FAFB),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: selectedCollege?.id == college.id
                                        ? color
                                        : const Color(0xFFE5E7EB),
                                  ),
                                ),
                                child: Text(
                                  college.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    const SizedBox(height: 4),
                  ],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildCollegeDetails(College college) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final padding = isMobile ? 16.0 : 32.0;
        final logoSize = isMobile ? 60.0 : 80.0;
        final titleSize = isMobile ? 22.0 : 28.0;

        return Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 30 : 40),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Center(
                  child: Icon(
                    college.logo,
                    size: logoSize,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 20 : 28),
              Text(
                college.name,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 18, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${college.city}, ${college.state}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha : 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    college.type,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 20 : 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Text(
                  college.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    height: 1.6,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 24 : 32),
              _buildDetailSection('College Details', [
                ('College Name', college.name),
                ('Location', '${college.city}, ${college.state}'),
                ('Type', college.type),
                ('Admission Deadline', college.admissionDeadline),
                ('Duration', '${college.duration} months'),
              ]),
              SizedBox(height: isMobile ? 24 : 32),
              _buildFAQSection([
                ('What is the benefit?', 'Comprehensive education with industry exposure and career opportunities.'),
                ('Why choose this college?', 'World-class faculty, modern facilities, and strong placement record.'),
                ('Eligibility', '12th pass or equivalent qualification required.'),
                ('Top reasons to study here', 'Industry partnerships, internships, and global recognition.'),
                ('Syllabus', 'Updated curriculum aligned with international standards.'),
                ('Documents required', 'Mark sheets, ID proof, and admission form.'),
                ('Career options', 'Multiple career paths across government and private sectors.'),
              ]),
              SizedBox(height: isMobile ? 24 : 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Contacting ${college.name}...'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Contact College',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 24 : 32),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailSection(
    String title,
    List<(String, String)> details,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details
                .asMap()
                .entries
                .map((entry) {
                  final (label, value) = entry.value;
                  final isLast = entry.key == details.length - 1;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$label: ',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (!isLast) const SizedBox(height: 14),
                    ],
                  );
                })
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFAQSection(List<(String, String)> faqs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        ...faqs.map((faq) {
          final (question, answer) = faq;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '✓ $question',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  answer,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}