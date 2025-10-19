import 'package:consultancy_website/models/college.dart';
import 'package:consultancy_website/widgets/college_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:consultancy_website/custom_app_bar.dart';
import 'package:consultancy_website/widgets/footer_widget.dart';

class ServicesMenu extends StatefulWidget {
  const ServicesMenu({super.key});

  @override
  State<ServicesMenu> createState() => _ServicesMenuState();
}

class _ServicesMenuState extends State<ServicesMenu> {
  String? expandedCategory;
  final Map<String, bool> expandedDegrees = {};
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
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 80 - 200,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = MediaQuery.of(context).size.width > 768;
                  return isDesktop ? _buildDesktopLayout() : _buildMobileLayout();
                },
              ),
            ),
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
          Container(
            width: 300,
            color: const Color(0xFFF9FAFB),
            child: SingleChildScrollView(
              child: _buildNavigationPanel(),
            ),
          ),
          Container(width: 1, color: const Color(0xFFE5E7EB)),
          Expanded(
            child: Container(
              color: Colors.white,
              child: selectedCollege != null
                  ? SingleChildScrollView(child: _buildCollegeDetails(selectedCollege!))
                  : const EmptyStateWidget(),
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
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
                const Expanded(
                  child: Text(
                    'College Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildCollegeDetails(selectedCollege!)),
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
          ),
        ),
        ...CategoryConfig.config.entries.map((entry) {
          final category = entry.key;
          final config = entry.value;
          final isExpanded = expandedCategory == category;
          return _buildCategoryItem(category, config, isExpanded);
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCategoryItem(String category, Map<String, dynamic> config, bool isExpanded) {
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
                    config['title'] as String,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(6),
                          border: Border(left: BorderSide(color: color, width: 3)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                degree,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Icon(
                              isDegreeExpanded ? Icons.expand_less : Icons.expand_more,
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
                          children: (CollegeData.data[category]?[degree] ?? []).map((college) {
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
                                      ? color.withValues(alpha: 0.15)
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
                                  style: const TextStyle(fontSize: 11),
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

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 24 : 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade50,
                        Colors.red.shade100,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(college.logo, size: 40, color: Colors.red),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        college.name,
                        style: TextStyle(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 18, color: Colors.red.shade700),
                          const SizedBox(width: 8),
                          Text(
                            '${college.city}, ${college.state}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          college.type,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // Description
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    college.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4B5563),
                      height: 1.7,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // Key Details Grid
                GridView.count(
                  crossAxisCount: isMobile ? 2 : 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.4,
                  children: [
                    InfoCard(
                      label: 'Duration',
                      value: '${college.duration}',
                      subvalue: 'months',
                      color: Colors.blue,
                      icon: Icons.schedule,
                    ),
                    InfoCard(
                      label: 'Deadline',
                      value: college.admissionDeadline.split('-')[0],
                      subvalue: college.admissionDeadline.split('-')[1],
                      color: Colors.orange,
                      icon: Icons.calendar_today,
                    ),
                    InfoCard(
                      label: 'College Type',
                      value: college.type,
                      subvalue: 'Institution',
                      color: Colors.green,
                      icon: Icons.school,
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // FAQ Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...[
                      'What is the benefit?',
                      'Why choose this college?',
                      'What is the eligibility?',
                      'What are the top reasons to study here?',
                      'What documents are required?',
                    ].map((question) => FAQItem(question: question)),
                  ],
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // Contact Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                SizedBox(height: isMobile ? 20 : 24),
              ],
            ),
          ),
        );
      },
    );
  }
}