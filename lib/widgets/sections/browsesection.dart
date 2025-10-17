import 'package:flutter/material.dart';

class BrowseCoursesSection extends StatefulWidget {
  const BrowseCoursesSection({super.key});

  @override
  State<BrowseCoursesSection> createState() => _BrowseCoursesSectionState();
}

class _BrowseCoursesSectionState extends State<BrowseCoursesSection> {
  late String activeCategory;
  late ScrollController _categoryScrollController;

  final List<String> categories = [
    'PG Courses',
    'Executive Education',
    'Doctorate/Ph.D',
    'UG Courses',
    'Job Guarantee',
    'Study Abroad',
    'Advanced Diploma',
  ];

  final Map<String, List<String>> coursesData = {
    'PG Courses': [
      'Master of Business Administration',
      'M.Tech Computer Science',
      'MA Economics',
      'M.Sc Data Science',
      'Master of Finance',
      'MBA Healthcare Management',
    ],
    'Executive Education': [
      'Executive Leadership Program',
      'Advanced Management Techniques',
      'Strategic Business Planning',
      'Digital Transformation Course',
      'Executive Communication',
      'Business Analytics for Executives',
    ],
    'Doctorate/Ph.D': [
      'Ph.D Computer Science',
      'Doctoral Program Engineering',
      'Ph.D Business Administration',
      'Research Methodology Program',
      'Advanced Research Studies',
      'Interdisciplinary Ph.D Program',
    ],
    'UG Courses': [
      'Bachelor of Technology',
      'B.Sc Computer Science',
      'Bachelor of Commerce',
      'B.A Economics',
      'Engineering Science',
      'Information Technology',
    ],
    'Job Guarantee': [
      'Full Stack Development Program',
      'Data Analytics Bootcamp',
      'Digital Marketing Mastery',
      'Cloud Computing Certification',
      'Machine Learning Intensive',
      'UI/UX Design Bootcamp',
    ],
    'Study Abroad': [
      'UK University Pathway',
      'US Education Program',
      'Canada Study Program',
      'Australia Admission Program',
      'European Universities',
      'Singapore Education Path',
    ],
    'Advanced Diploma': [
      'Diploma Advanced Computing',
      'Professional Engineering Diploma',
      'Business Management Diploma',
      'Digital Media Diploma',
      'Cybersecurity Diploma',
      'Advanced IT Infrastructure',
    ],
  };

  final List<Color> iconColors = [
    const Color(0xFFE74C3C), // Red
    const Color(0xFF3498DB), // Blue
    const Color(0xFF2C3E50), // Black
    const Color(0xFFE74C3C),
    const Color(0xFF3498DB),
    const Color(0xFF2C3E50),
  ];

  @override
  void initState() {
    super.initState();
    activeCategory = categories.first;
    _categoryScrollController = ScrollController();
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth < 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 16 : isTablet ? 24 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFF8F9FA),
          ],
        ),
      ),
      child: Column(
        children: [
          // Section Title with Gradient
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                const Color(0xFF2C3E50),
                const Color(0xFFE74C3C),
              ],
            ).createShader(bounds),
            child: Text(
              'Browse Courses',
              style: TextStyle(
                fontSize: isMobile ? 28 : isTablet ? 36 : 48,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          // Subtitle
          Text(
            'Explore our comprehensive course offerings',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: const Color(0xFF7F8C8D),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),

          // Categories Horizontal Scroll
          Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: SingleChildScrollView(
              controller: _categoryScrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                  categories.length,
                  (index) {
                    final category = categories[index];
                    final isActive = category == activeCategory;
                    return Padding(
                      padding: EdgeInsets.only(right: isMobile ? 8 : 12),
                      child: _buildCategoryButton(category, isActive),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // Courses Grid with Animation
          Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
              child: _buildCoursesGrid(isMobile, isTablet),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [
                    const Color(0xFF2C3E50),
                    const Color(0xFF34495E),
                  ],
                )
              : null,
          color: isActive ? null : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? const Color(0xFFE74C3C) : const Color(0xFFE5E5E5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? const Color(0xFFE74C3C).withValues(alpha : 0.3)
                  : Colors.black.withValues(alpha : 0.05),
              blurRadius: isActive ? 12 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF2C3E50),
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            fontSize: 13,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _buildCoursesGrid(bool isMobile, bool isTablet) {
    final courses = coursesData[activeCategory] ?? [];
    
    if (courses.isEmpty) {
      return const Center(
        child: Text('No courses available'),
      );
    }

    int crossAxisCount;

    if (isMobile) {
      crossAxisCount = 2;
    } else if (isTablet) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    return Column(
      key: ValueKey(activeCategory),
      children: [
        // Courses Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isMobile ? 12 : 20,
            mainAxisSpacing: isMobile ? 16 : 24,
            childAspectRatio: 0.95,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return _buildCourseCard(courses[index], index);
          },
        ),
        const SizedBox(height: 50),

        // View All Button
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFE74C3C),
                const Color(0xFFC0392B),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE74C3C).withValues(alpha : 0.4),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Add navigation or action here
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 40,
                  vertical: 16,
                ),
                child: Text(
                  'View All $activeCategory',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 14 : 16,
                    fontFamily: 'Montserrat',
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(String courseName, int index) {
    final Color accentColor = iconColors[index % iconColors.length];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Add course details navigation here
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with Gradient Background
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        accentColor.withValues(alpha : 0.15),
                        accentColor.withValues(alpha : 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: accentColor.withValues(alpha : 0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha : 0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    size: 36,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 18),

                // Course Name
                Text(
                  courseName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Bottom accent line
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor,
                        accentColor.withValues(alpha : 0.5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}