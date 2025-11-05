import 'package:consultancy_website/models/college.dart';
import 'package:flutter/material.dart';

class ServicesDropdown extends StatefulWidget {
  final VoidCallback onClose;

  const ServicesDropdown({super.key, required this.onClose});

  @override
  State<ServicesDropdown> createState() => _ServicesDropdownState();

  static List<Widget> getMobileMenuItems() {
    final List<Widget> items = [];

    CategoryConfig.config.forEach((category, config) {
      final degrees = CollegeData.data[category]?.keys.toList() ?? [];

      items.add(
        ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.only(bottom: 8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              config['icon'] as IconData,
              color: const Color(0xFFEF4444),
              size: 20,
            ),
          ),
          title: Text(
            config['title'] as String,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF6B7280),
          ),
          children: degrees.map((degree) {
            final colleges = CollegeData.data[category]?[degree] ?? [];
            return Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text(
                  degree,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                  ),
                ),
                subtitle: Text(
                  '${colleges.length} ${colleges.length == 1 ? 'college' : 'colleges'}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFFEF4444),
                ),
                onTap: () {
                  // Handle navigation if needed
                },
              ),
            );
          }).toList(),
        ),
      );
    });

    return items;
  }
}

class _ServicesDropdownState extends State<ServicesDropdown> {
  String? selectedCategory;
  String? selectedDegree;
  String? expandedLevel;
  final Map<String, bool> _showMoreMap = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    // For mobile, show the expansion tile view
    if (isMobile) {
      return Container(
        width: double.infinity,
        height: screenHeight * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Back arrow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: widget.onClose,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            ),
            // Services header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.business_center,
                      color: Color(0xFFEF4444),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
            // Scrollable list
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: ServicesDropdown.getMobileMenuItems(),
              ),
            ),
          ],
        ),
      );
    }

    // Desktop/Tablet view
    return Container(
      constraints: BoxConstraints(
        maxHeight: screenWidth < 1024 ? screenHeight * 0.75 : 600,
        maxWidth: screenWidth < 1024 ? 500 : 600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFEF4444), width: 3),
          bottom: BorderSide(color: Color(0xFFEF4444), width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: selectedCategory == null
            ? _buildAllCoursesView(screenWidth)
            : _buildCategoryDetailsView(screenWidth),
      ),
    );
  }

  Widget _buildAllCoursesView(double screenWidth) {
    final levels = ['Undergraduate', 'Graduate', 'PhD'];
    final isSmallScreen = screenWidth < 600;
    final padding = isSmallScreen ? 16.0 : 20.0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Courses',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 8),
                Container(height: 1, color: const Color(0xFFE5E7EB)),
              ],
            ),
          ),

          // Courses by Level
          ...levels.map((level) {
            return _buildLevelSection(level, screenWidth);
          }),

          SizedBox(height: isSmallScreen ? 16 : 20),
        ],
      ),
    );
  }

  Widget _buildLevelSection(String level, double screenWidth) {
    final categories = CategoryConfig.config.entries.toList();
    final showAll = _showMoreMap[level] ?? false;
    final itemsToShow = showAll ? categories.length : 4;
    final displayedCategories = categories.take(itemsToShow).toList();
    final isSmallScreen = screenWidth < 600;
    final padding = isSmallScreen ? 16.0 : 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Level Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 12),
          child: Text(
            'For $level',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B7280),
              letterSpacing: 0.5,
            ),
          ),
        ),

        // Categories List
        ...displayedCategories.map((entry) {
          final category = entry.key;
          final config = entry.value;

          return _buildCategoryListItem(
            category: category,
            config: config,
            screenWidth: screenWidth,
          );
        }),

        // Show More Button
        if (categories.length > 4)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _showMoreMap[level] = !showAll;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    showAll ? 'Show Less' : 'Show More',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    showAll
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: isSmallScreen ? 18 : 20,
                    color: const Color(0xFFEF4444),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCategoryListItem({
    required String category,
    required Map<String, dynamic> config,
    required double screenWidth,
  }) {
    final title = config['title'] as String;

    return _CategoryListItem(
      title: title,
      screenWidth: screenWidth,
      onTap: () {
        setState(() {
          selectedCategory = category;
          selectedDegree = null;
        });
      },
    );
  }

  Widget _buildCategoryDetailsView(double screenWidth) {
    final config = CategoryConfig.config[selectedCategory!];
    final degrees = CollegeData.data[selectedCategory!]?.keys.toList() ?? [];
    final title = config?['title'] as String? ?? selectedCategory!;

    if (selectedDegree != null) {
      return _buildCollegesListView(screenWidth);
    }

    final isSmallScreen = screenWidth < 600;
    final padding = isSmallScreen ? 16.0 : 20.0;

    return Column(
      children: [
        // Header with Back Button
        Container(
          padding: EdgeInsets.all(padding),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
            ),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedCategory = null;
                    selectedDegree = null;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: isSmallScreen ? 18 : 20,
                      color: const Color(0xFF111827),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Back',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Category Title and "View All" link
        Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'FOR ALL DOMAINS',
                style: TextStyle(
                  fontSize: isSmallScreen ? 11 : 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 0.5,
                ),
              ),
              if (screenWidth >= 600) ...[
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    // Handle "View All" action
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View All $title Courses',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Color(0xFFEF4444),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // Degrees List
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: degrees.map((degree) {
                return _buildDegreeListItem(degree, screenWidth);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDegreeListItem(String degree, double screenWidth) {
    return _DegreeListItem(
      degree: degree,
      screenWidth: screenWidth,
      onTap: () {
        setState(() {
          selectedDegree = degree;
        });
      },
    );
  }

  Widget _buildCollegesListView(double screenWidth) {
    final config = CategoryConfig.config[selectedCategory!];
    final title = config?['title'] as String? ?? selectedCategory!;
    final colleges =
        CollegeData.data[selectedCategory!]?[selectedDegree!] ?? [];
    final isSmallScreen = screenWidth < 600;
    final padding = isSmallScreen ? 16.0 : 20.0;

    return Column(
      children: [
        // Header with Back Button
        Container(
          padding: EdgeInsets.all(padding),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
            ),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedDegree = null;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: isSmallScreen ? 18 : 20,
                      color: const Color(0xFF111827),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Back',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Degree Title
        Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedDegree!,
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'FROM $title',
                style: TextStyle(
                  fontSize: isSmallScreen ? 11 : 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        // Colleges List
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: colleges.map((college) {
                return _CollegeListItem(
                  college: college,
                  screenWidth: screenWidth,
                  onTap: () {
                    widget.onClose();
                    Navigator.pushNamed(
                      context,
                      '/college-details',
                      arguments: college,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// Category List Item with hover effect
class _CategoryListItem extends StatefulWidget {
  final String title;
  final double screenWidth;
  final VoidCallback onTap;

  const _CategoryListItem({
    required this.title,
    required this.screenWidth,
    required this.onTap,
  });

  @override
  State<_CategoryListItem> createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<_CategoryListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = widget.screenWidth < 600;
    final padding = isSmallScreen ? 16.0 : 20.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: isSmallScreen ? 14 : 16,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w400,
                    color: _isHovered
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF111827),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: isSmallScreen ? 18 : 20,
                color: _isHovered
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Degree List Item with hover effect
class _DegreeListItem extends StatefulWidget {
  final String degree;
  final double screenWidth;
  final VoidCallback onTap;

  const _DegreeListItem({
    required this.degree,
    required this.screenWidth,
    required this.onTap,
  });

  @override
  State<_DegreeListItem> createState() => _DegreeListItemState();
}

class _DegreeListItemState extends State<_DegreeListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = widget.screenWidth < 600;
    final padding = isSmallScreen ? 16.0 : 20.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: isSmallScreen ? 14 : 16,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.degree,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w400,
                    color: _isHovered
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF111827),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: isSmallScreen ? 18 : 20,
                color: _isHovered
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// College List Item
class _CollegeListItem extends StatefulWidget {
  final College college;
  final double screenWidth;
  final VoidCallback onTap;

  const _CollegeListItem({
    required this.college,
    required this.screenWidth,
    required this.onTap,
  });

  @override
  State<_CollegeListItem> createState() => _CollegeListItemState();
}

class _CollegeListItemState extends State<_CollegeListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = widget.screenWidth < 600;
    final padding = isSmallScreen ? 16.0 : 20.0;
    final logoSize = isSmallScreen ? 40.0 : 48.0;
    final iconSize = isSmallScreen ? 20.0 : 24.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
            ),
          ),
          child: Row(
            children: [
              // College Logo
              Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                ),
                child: Icon(
                  widget.college.logo,
                  size: iconSize,
                  color: _isHovered
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF6B7280),
                ),
              ),
              SizedBox(width: isSmallScreen ? 12 : 16),
              // College Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.college.name,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 13 : 14,
                        fontWeight: FontWeight.w500,
                        color: _isHovered
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF111827),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.college.name,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 13,
                        fontWeight: FontWeight.w600,
                        color: _isHovered
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF111827),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
