import 'package:flutter/material.dart';

class ResourcesMenu extends StatelessWidget {
  const ResourcesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuHeader(),
            const SizedBox(height: 24),
            _buildResourceCategories(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF8B5CF6),
                const Color(0xFFA855F7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B5CF6).withValues(alpha : 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.library_books_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Resources',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildResourceCategories() {
    return Column(
      children: [
        _buildResourceCategory(
          'Learning Resources',
          [
            {
              'title': 'INK Interactive Kit',
              'subtitle': 'Interactive storytelling',
              'icon': Icons.auto_stories_outlined,
            },
            {
              'title': 'Blogs',
              'subtitle': 'Educational articles',
              'icon': Icons.article_outlined,
            },
            {
              'title': 'Videos',
              'subtitle': 'Video content',
              'icon': Icons.video_library_outlined,
            },
          ],
          const Color(0xFF8B5CF6),
        ),
        const SizedBox(height: 20),
        _buildResourceCategory(
          'About Us',
          [
            {
              'title': 'Why Choose Us',
              'subtitle': 'Our unique value',
              'icon': Icons.star_outline,
            },
            {
              'title': 'Work With Us',
              'subtitle': 'Career opportunities',
              'icon': Icons.handshake_outlined,
            },
          ],
          const Color(0xFFEF4444),
        ),
      ],
    );
  }

  Widget _buildResourceCategory(String categoryTitle, List<Map<String, dynamic>> resources, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha : 0.06),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColor.withValues(alpha : 0.1),
                  accentColor.withValues(alpha : 0.05),
                ],
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha : 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.folder_outlined,
                    color: accentColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  categoryTitle,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: accentColor,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
          ...resources.asMap().entries.map((entry) {
            final index = entry.key;
            final resource = entry.value;
            final isLast = index == resources.length - 1;
            
            return _buildResourceItem(
              resource['title'] as String,
              resource['subtitle'] as String,
              resource['icon'] as IconData,
              accentColor,
              isLast,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResourceItem(String title, String subtitle, IconData icon, Color accentColor, bool isLast) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('Tapped on: $title');
        },
        borderRadius: isLast 
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
          : null,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xFFF3F4F6),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha : 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: accentColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<Widget> getMobileMenuItems() {
    final learningResources = [
      'INK Interactive Kit',
      'Blogs',
      'Videos',
    ];

    final aboutUsResources = [
      'Why Choose Us',
      'Work With Us',
    ];

    List<Widget> allItems = [];
    
    // Learning Resources Header
    allItems.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF8B5CF6).withValues(alpha : 0.1),
              const Color(0xFF8B5CF6).withValues(alpha : 0.05),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withValues(alpha : 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.folder_outlined,
                size: 14,
                color: Color(0xFF8B5CF6),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Learning Resources',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8B5CF6),
              ),
            ),
          ],
        ),
      ),
    );
    
    // Learning Resources Items
    allItems.addAll(
      learningResources.map((resource) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('Mobile tapped: $resource');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFF3F4F6),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6).withValues(alpha : 0.6),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    resource,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1F2937),
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
      )),
    );

    // About Us Header
    allItems.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFEF4444).withValues(alpha : 0.1),
              const Color(0xFFEF4444).withValues(alpha : 0.05),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha : 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.folder_outlined,
                size: 14,
                color: Color(0xFFEF4444),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'About Us',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEF4444),
              ),
            ),
          ],
        ),
      ),
    );
    
    // About Us Items
    allItems.addAll(
      aboutUsResources.map((resource) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('Mobile tapped: $resource');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFF3F4F6),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha : 0.6),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    resource,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1F2937),
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
      )),
    );

    return allItems;
  }
}