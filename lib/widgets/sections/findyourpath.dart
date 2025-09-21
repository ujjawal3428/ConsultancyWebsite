import 'package:flutter/material.dart';

class FindYourPathSection extends StatelessWidget {
  const FindYourPathSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _ = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isMobile = screenWidth < 768;
    
    return Column(
      children: [
        // Grey background section - ends at middle of service cards
        Stack(
          children: [
            // Grey background container
            Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 40 : 80,
                  horizontal: isMobile ? 16 : 20,
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  width: double.infinity,
                  child: isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildImagePlaceholder(isMobile: true),
                            const SizedBox(height: 40),
                            _buildLeftContent(isMobile: true),
                            const SizedBox(height: 40),
                            // Add space for half of service card height
                            SizedBox(height: _getServiceCardHeight(true) / 2),
                          ],
                        )
                      : isTablet
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: _buildImagePlaceholder(isTablet: true),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: _buildLeftContent(isTablet: true),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 60),
                                // Add space for half of service card height
                                SizedBox(height: _getServiceCardHeight(false) / 2),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: _buildImagePlaceholder(),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: _buildLeftContent(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 80),
                                // Add space for half of service card height
                                SizedBox(height: _getServiceCardHeight(false) / 2),
                              ],
                            ),
                ),
              ),
            ),
            // Positioned service cards that overlap the background boundary
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
                  child: _buildServiceCards(
                    isMobile: isMobile, 
                    isTablet: isTablet, 
                    isDesktop: !isMobile && !isTablet
                  ),
                ),
              ),
            ),
          ],
        ),
        
        // White background section - starts from middle of service cards
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              // Add space for the bottom half of service cards
              SizedBox(height: _getServiceCardHeight(isMobile) / 2),
              
              // Add spacing between service cards and additional content
              SizedBox(height: isMobile ? 20 : 0),
              
              // Additional content without background
              _buildAdditionalContent(isMobile: isMobile),
               SizedBox(height: isMobile ? 20 : 10),
              
              // Admissions Open Section
              _buildAdmissionsSection(isMobile: isMobile, isTablet: isTablet),
              
              // Bottom padding
              SizedBox(height: isMobile ? 40 : 60),
            ],
          ),
        ),
      ],
    );
  }

  double _getServiceCardHeight(bool isMobile) {
    // Calculate approximate height of service cards including padding
    double iconSize = isMobile ? 20 : 35;
    double iconTextSpacing = isMobile ? 8 : 20;
    double textHeight = isMobile ? 24 : 34; // Approximate for 2 lines
    double cardPadding = isMobile ? 24 : 40; // Top + bottom padding
    double rowSpacing = isMobile ? 16 : 20; // For mobile/tablet 2-row layout
    
    return iconSize + iconTextSpacing + textHeight + cardPadding + (isMobile ? rowSpacing : 0);
  }

  Widget _buildLeftContent({bool isMobile = false, bool isTablet = false}) {
    return Container(
      padding: EdgeInsets.only(left: isMobile ? 0 : 50),
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          // Main Heading
          Text(
            'Find Your Path',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontFamily: 'The Seasons',
              fontSize: isMobile ? 28 : isTablet ? 40 : 55,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 24),
          
          // Subtitle
          Text(
            'Discover the next steps in your\neducational journey!',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: isMobile ? 18 : isTablet ? 20 : 24,
              fontWeight: FontWeight.w400,
              color: Colors.black.withValues(alpha : 0.8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 40),
          
          // CTA Button
          ElevatedButton(
            onPressed: () {
              // Add navigation logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626), // Red color
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 14 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              'Book An Appointment',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder({bool isMobile = false, bool isTablet = false}) {
    return Container(
      height: isMobile ? 250 : isTablet ? 350 : 400,
      margin: EdgeInsets.only(right: isMobile ? 0 : 40, left: isMobile ? 0 : 60),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha : 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha : 0.3),
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              size: isMobile ? 32 : isTablet ? 40 : 48,
              color: Colors.grey.withValues(alpha : 0.6),
            ),
            const SizedBox(height: 8),
            Text(
              'Image Placeholder',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: isMobile ? 14 : 16,
                color: Colors.grey.withValues(alpha : 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCards({required bool isMobile, required bool isTablet, required bool isDesktop}) {
    final serviceData = [
      {'icon': Icons.school_outlined, 'title': 'Boarding School\nAdmissions'},
      {'icon': Icons.person_outline, 'title': 'Undergraduate\nPreparation'},
      {'icon': Icons.school_outlined, 'title': 'Undergraduate\nAdmissions'},
      {'icon': Icons.school_outlined, 'title': 'Postgraduate\nAdmissions'},
      {'icon': Icons.business_center_outlined, 'title': 'MBA Admissions'},
      {'icon': Icons.people_outline, 'title': 'Education\nCounselling'},
    ];

    if (isDesktop) {
      // Desktop: All 6 cards in single row (6x1) - all cards at the border
      return Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          children: serviceData.map((service) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildServiceCard(
                  icon: service['icon'] as IconData,
                  title: service['title'] as String,
                  isMobile: false,
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else if (isTablet) {
      // Tablet: 3x2 layout - first row cards at the border
      return Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            Row(
              children: serviceData.take(3).map((service) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildServiceCard(
                      icon: service['icon'] as IconData,
                      title: service['title'] as String,
                      isMobile: false,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: serviceData.skip(3).take(3).map((service) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildServiceCard(
                      icon: service['icon'] as IconData,
                      title: service['title'] as String,
                      isMobile: false,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    } else {
      // Mobile: 3x1 layout - only first row (3 cards) at the border
      return Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            Row(
              children: serviceData.take(3).map((service) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildServiceCard(
                      icon: service['icon'] as IconData,
                      title: service['title'] as String,
                      isMobile: true,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: serviceData.skip(3).take(3).map((service) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildServiceCard(
                      icon: service['icon'] as IconData,
                      title: service['title'] as String,
                      isMobile: true,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    bool isMobile = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha : 0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            hoverColor: const Color(0xFFDC2626),
            onTap: () {
              // Add tap functionality here
            },
            child: Builder(
              builder: (BuildContext context) {
                bool isHovered = false;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return MouseRegion(
                      onEnter: (_) => setState(() => isHovered = true),
                      onExit: (_) => setState(() => isHovered = false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isHovered ? const Color(0xFFDC2626) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isMobile ? 12 : 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icon,
                                size: isMobile ? 20 : 35,
                                color: isHovered 
                                    ? Colors.black 
                                    : Colors.black.withValues(alpha: 0.8),
                              ),
                              SizedBox(height: isMobile ? 8 : 20),
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: isMobile ? 10 : 14,
                                  fontWeight: FontWeight.w600,
                                  color: isHovered ? Colors.white : Colors.black,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalContent({bool isMobile = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 30 : 10,
        horizontal: isMobile ? 16 : 20,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 20),
        child: Column(
          children: [
            // Description text
            Text(
              'At the Red Pen, our consultants, who have graduated from some of the world\'s most prestigious universities, are determined to help you apply to universities that align with your potential and aspirations.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w400,
                color: Colors.black.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            
            // Learn More button
            ElevatedButton(
              onPressed: () {
                // Add navigation logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626), // Red color
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 24,
                  vertical: isMobile ? 12 : 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: Text(
                'Learn More',
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdmissionsSection({bool isMobile = false, bool isTablet = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 80,
        horizontal: isMobile ? 16 : 20,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            // Fall 2025 Admissions
            Text(
              'Fall 2025 Admissions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: isMobile ? 24 : isTablet ? 28 : 32,
                fontWeight: FontWeight.w600,
                color: Colors.black.withValues(alpha: 0.9),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            
            // Subtitle
            Text(
              'We have admissions to the world\'s most prestigious universities and programmes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: isMobile ? 16 : isTablet ? 18 : 20,
                fontWeight: FontWeight.w400,
                color: Colors.black.withValues(alpha: 0.7),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 50),
            
            // Admission Cards Grid
            _buildAdmissionCards(isMobile: isMobile, isTablet: isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildAdmissionCards({bool isMobile = false, bool isTablet = false}) {
    final admissionData = [
      {
        'title': 'Our Undergraduate\nAdmissions for Fall 2025',
        'color': const Color(0xFF1a1a1a),
        'image': 'undergraduate_placeholder',
      },
      {
        'title': 'Our Postgraduate\nAdmissions for Fall 2025', 
        'color': const Color(0xFF2d4a87),
        'image': 'postgraduate_placeholder',
      },
      {
        'title': 'Our MBA\nAdmissions for Fall 2025',
        'color': const Color(0xFF4a2d87),
        'image': 'mba_placeholder',
      },
      {
        'title': 'Our Boarding School\nAdmissions for Fall 2025',
        'color': const Color(0xFF8b2d2d),
        'image': 'boarding_school_placeholder',
      },
    ];

    if (isMobile) {
      // Mobile: 2x2 grid
      return Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildAdmissionCard(
                      title: admissionData[0]['title'] as String,
                      color: admissionData[0]['color'] as Color,
                      isMobile: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildAdmissionCard(
                      title: admissionData[1]['title'] as String,
                      color: admissionData[1]['color'] as Color,
                      isMobile: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildAdmissionCard(
                      title: admissionData[2]['title'] as String,
                      color: admissionData[2]['color'] as Color,
                      isMobile: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildAdmissionCard(
                      title: admissionData[3]['title'] as String,
                      color: admissionData[3]['color'] as Color,
                      isMobile: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // Desktop/Tablet: 1x4 row
      return Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          children: admissionData.map((data) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildAdmissionCard(
                  title: data['title'] as String,
                  color: data['color'] as Color,
                  isMobile: false,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  Widget _buildAdmissionCard({
    required String title,
    required Color color,
    bool isMobile = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Add navigation logic here
        },
        child: Container(
          height: isMobile ? 200 : 280,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background image placeholder
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color.withValues(alpha: 0.7),
                        color,
                      ],
                    ),
                  ),
                ),
              ),
              
              // Content
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: isMobile ? 14 : 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 30,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDC2626),
                        borderRadius: BorderRadius.circular(2),
                      ),
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