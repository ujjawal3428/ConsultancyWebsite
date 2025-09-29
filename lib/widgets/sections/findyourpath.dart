import 'package:flutter/material.dart';

class FindYourPathSection extends StatelessWidget {
  const FindYourPathSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isMobile = screenWidth < 768;

    return Column(
      children: [
        // Grey background section with main content
        Container(
          width: double.infinity,
          color: Colors.grey[100],
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 80,
              horizontal: isMobile ? 16 : 20,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                width: double.infinity,
                child: _buildMainContent(
                  isMobile: isMobile,
                  isTablet: isTablet,
                  isDesktop: isDesktop,
                ),
              ),
            ),
          ),
        ),

        // Service cards section with overlapping effect
        Transform.translate(
          offset: Offset(0, isMobile ? -40 : -60),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: _buildServiceCards(
                  isMobile: isMobile,
                  isTablet: isTablet,
                  isDesktop: isDesktop,
                ),
              ),
            ),
          ),
        ),

        // White background section with remaining content
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              // Adjust spacing after service cards
              SizedBox(height: isMobile ? 0 : 20),

              // Additional content
              _buildAdditionalContent(isMobile: isMobile),
              SizedBox(height: isMobile ? 20 : 40),

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

  Widget _buildMainContent({
    required bool isMobile,
    required bool isTablet,
    required bool isDesktop,
  }) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImagePlaceholder(isMobile: true),
          const SizedBox(height: 32),
          _buildLeftContent(isMobile: true),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: 5,
            child: _buildImagePlaceholder(
              isTablet: isTablet,
              isDesktop: isDesktop,
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 5,
            child: _buildLeftContent(isTablet: isTablet, isDesktop: isDesktop),
          ),
        ],
      );
    }
  }

  Widget _buildLeftContent({
    bool isMobile = false,
    bool isTablet = false,
    bool isDesktop = false,
  }) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Main Heading
        Text(
          'Find Your Path',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontFamily: 'The Seasons',
            fontSize: _getResponsiveFontSize(
              mobile: 28,
              tablet: 42,
              desktop: 55,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
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
            fontSize: _getResponsiveFontSize(
              mobile: 16,
              tablet: 18,
              desktop: 22,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            fontWeight: FontWeight.w400,
            color: Colors.black.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 32),

        // CTA Button
        SizedBox(
          width: isMobile ? double.infinity : null,
          child: ElevatedButton(
            onPressed: () {
              // Add navigation logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 16 : 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            child: Text(
              'Book An Appointment',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: _getResponsiveFontSize(
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                  isMobile: isMobile,
                  isTablet: isTablet,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 40 : 0),
      ],
    );
  }

  Widget _buildImagePlaceholder({
    bool isMobile = false,
    bool isTablet = false,
    bool isDesktop = false,
  }) {
    return Container(
      height: isMobile
          ? 250
          : isTablet
          ? 320
          : 380,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              size: isMobile
                  ? 32
                  : isTablet
                  ? 40
                  : 48,
              color: Colors.grey.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 8),
            Text(
              'Image Placeholder',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: isMobile ? 14 : 16,
                color: Colors.grey.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCards({
    required bool isMobile,
    required bool isTablet,
    required bool isDesktop,
  }) {
    final serviceData = [
      {'icon': Icons.school_outlined, 'title': 'Boarding School\nAdmissions'},
      {'icon': Icons.person_outline, 'title': 'Undergraduate\nPreparation'},
      {'icon': Icons.school_outlined, 'title': 'Undergraduate\nAdmissions'},
      {'icon': Icons.school_outlined, 'title': 'Postgraduate\nAdmissions'},
      {'icon': Icons.business_center_outlined, 'title': 'MBA Admissions'},
      {'icon': Icons.people_outline, 'title': 'Education\nCounselling'},
    ];

    if (isDesktop) {
      // Desktop: All 6 cards in single row
      return Row(
        children: serviceData.map((service) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _ServiceCard(
                icon: service['icon'] as IconData,
                title: service['title'] as String,
                isMobile: false,
              ),
            ),
          );
        }).toList(),
      );
    } else if (isTablet) {
      // Tablet: 3x2 layout
      return Column(
        children: [
          Row(
            children: serviceData.take(3).map((service) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _ServiceCard(
                    icon: service['icon'] as IconData,
                    title: service['title'] as String,
                    isMobile: false,
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
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _ServiceCard(
                    icon: service['icon'] as IconData,
                    title: service['title'] as String,
                    isMobile: false,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    } else {
      // Mobile: 2x3 layout for better fit
      return Column(
        children: [
          Row(
            children: serviceData.take(2).map((service) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _ServiceCard(
                    icon: service['icon'] as IconData,
                    title: service['title'] as String,
                    isMobile: true,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: serviceData.skip(2).take(2).map((service) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _ServiceCard(
                    icon: service['icon'] as IconData,
                    title: service['title'] as String,
                    isMobile: true,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: serviceData.skip(4).take(2).map((service) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _ServiceCard(
                    icon: service['icon'] as IconData,
                    title: service['title'] as String,
                    isMobile: true,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    }
  }

  Widget _buildAdditionalContent({bool isMobile = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'At the Red Pen, our consultants, who have graduated from some of the world\'s most prestigious universities, are determined to help you apply to universities that align with your potential and aspirations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: isMobile ? 15 : 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 32,
                    vertical: isMobile ? 12 : 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Learn More',
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdmissionsSection({
    bool isMobile = false,
    bool isTablet = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 50 : 70,
        horizontal: isMobile ? 16 : 20,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Fall 2025 Admissions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: _getResponsiveFontSize(
                    mobile: 24,
                    tablet: 28,
                    desktop: 32,
                    isMobile: isMobile,
                    isTablet: isTablet,
                  ),
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withValues(alpha: 0.9),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'We have admissions to the world\'s most prestigious universities and programmes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: _getResponsiveFontSize(
                    mobile: 15,
                    tablet: 17,
                    desktop: 19,
                    isMobile: isMobile,
                    isTablet: isTablet,
                  ),
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withValues(alpha: 0.7),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),

              _buildAdmissionCards(isMobile: isMobile, isTablet: isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdmissionCards({bool isMobile = false, bool isTablet = false}) {
    final admissionData = [
      {
        'title': 'Our Undergraduate\nAdmissions for Fall 2025',
        'color': const Color(0xFF1a1a1a),
      },
      {
        'title': 'Our Postgraduate\nAdmissions for Fall 2025',
        'color': const Color(0xFF2d4a87),
      },
      {
        'title': 'Our MBA\nAdmissions for Fall 2025',
        'color': const Color(0xFF4a2d87),
      },
      {
        'title': 'Our Boarding School\nAdmissions for Fall 2025',
        'color': const Color(0xFF8b2d2d),
      },
    ];

    if (isMobile) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: _buildAdmissionCard(
                    title: admissionData[0]['title'] as String,
                    color: admissionData[0]['color'] as Color,
                    isMobile: true,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: _buildAdmissionCard(
                    title: admissionData[1]['title'] as String,
                    color: admissionData[1]['color'] as Color,
                    isMobile: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: _buildAdmissionCard(
                    title: admissionData[2]['title'] as String,
                    color: admissionData[2]['color'] as Color,
                    isMobile: true,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
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
      );
    } else {
      return Row(
        children: admissionData.map((data) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildAdmissionCard(
                title: data['title'] as String,
                color: data['color'] as Color,
                isMobile: false,
              ),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildAdmissionCard({
    required String title,
    required Color color,
    bool isMobile = false,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: isMobile ? 160 : 240,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color.withValues(alpha: 0.8), color],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: isMobile ? 12 : 16,
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
    );
  }

  double _getResponsiveFontSize({
    required double mobile,
    required double tablet,
    required double desktop,
    required bool isMobile,
    required bool isTablet,
  }) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }
}

// Separate StatefulWidget for service cards to handle hover properly
class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isMobile;

  const _ServiceCard({
    required this.icon,
    required this.title,
    this.isMobile = false,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _textColorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: const Color(0xFFDC2626),
    ).animate(_animationController);

    _textColorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHoverChange(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHoverChange(true),
      onExit: (_) => _handleHoverChange(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: _isHovered ? 0.15 : 0.05,
                    ),
                    blurRadius: _isHovered ? 25 : 15,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: Matrix4.identity()
                        // ignore: deprecated_member_use
                        ..scale(_isHovered ? 1.1 : 1.0),
                      child: Icon(
                        widget.icon,
                        size: widget.isMobile ? 24 : 32,
                        color: _textColorAnimation.value,
                      ),
                    ),
                    SizedBox(height: widget.isMobile ? 12 : 16),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: widget.isMobile ? 11 : 14,
                        fontWeight: FontWeight.w600,
                        color: _textColorAnimation.value,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}