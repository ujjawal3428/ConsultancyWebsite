import 'package:flutter/material.dart';

class BrandsSection extends StatefulWidget {
  const BrandsSection({super.key});

  @override
  State<BrandsSection> createState() => _BrandsSectionState();
}

class _BrandsSectionState extends State<BrandsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _scrollController;
  late Animation<double> _scrollAnimation;

  // Brand logos data
  final List<BrandData> brands = [
    BrandData(
      name: 'ESADE',
      logo: 'assets/images/brands/founders.png',
    ),
    BrandData(
      name: 'ESCP Business School',
      logo: 'assets/images/brands/founders.png',
    ),
    BrandData(
      name: 'Frankfurt School',
      logo: 'assets/images/brands/founders.png',
    ),
    BrandData(
      name: 'Harvard University',
      logo: 'assets/images/brands/founders.png',
    ),
    BrandData(
      name: 'IE Business School',
      logo: 'assets/images/brands/founders.png',
    ),
    BrandData(
      name: 'Imperial College London',
      logo: 'assets/images/brands/founders.png',
    ),
    BrandData(
      name: 'Founders',
      logo: 'assets/images/brands/founders.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      duration: const Duration(seconds: 20), // Adjust speed here
      vsync: this,
    );

    _scrollAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scrollController,
      curve: Curves.linear,
    ));

    // Start continuous animation
    _scrollController.repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Helper method to determine screen size category
  ScreenSize _getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return ScreenSize.mobile;
    if (width < 1200) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  // Helper method to get responsive values
  ResponsiveValues _getResponsiveValues(BuildContext context) {
    final screenSize = _getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return ResponsiveValues(
          titleFontSize: 28,
          verticalPadding: 40,
          horizontalPadding: 20,
          brandHeight: 80,
          brandWidth: 200,
          brandMargin: 10,
          logoHeight: 50,
          statNumberFontSize: 36,
          statLabelFontSize: 14,
          statColumns: 2,
          titleMaxLines: 3,
        );
      case ScreenSize.tablet:
        return ResponsiveValues(
          titleFontSize: 36,
          verticalPadding: 60,
          horizontalPadding: 30,
          brandHeight: 100,
          brandWidth: 240,
          brandMargin: 15,
          logoHeight: 65,
          statNumberFontSize: 48,
          statLabelFontSize: 16,
          statColumns: 4,
          titleMaxLines: 2,
        );
      case ScreenSize.desktop:
        return ResponsiveValues(
          titleFontSize: 48,
          verticalPadding: 80,
          horizontalPadding: 40,
          brandHeight: 120,
          brandWidth: 280,
          brandMargin: 20,
          logoHeight: 80,
          statNumberFontSize: 64,
          statLabelFontSize: 18,
          statColumns: 4,
          titleMaxLines: 2,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = _getResponsiveValues(context);
    
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // White section with title and brands
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: responsive.verticalPadding.toDouble(),
              horizontal: responsive.horizontalPadding.toDouble(),
            ),
            child: Column(
              children: [
                // Title
                Text(
                  'Our applicants have been admitted to',
                  style: TextStyle(
                    fontSize: responsive.titleFontSize.toDouble(),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D3748),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: responsive.titleMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: responsive.verticalPadding * 0.75),
                
                // Scrolling brands
                SizedBox(
                  height: responsive.brandHeight.toDouble(),
                  child: AnimatedBuilder(
                    animation: _scrollAnimation,
                    builder: (context, child) {
                      return _buildScrollingBrands(responsive);
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Black section with statistics
          Container(
            width: double.infinity,
            color: Colors.black,
            padding: EdgeInsets.symmetric(
              vertical: responsive.verticalPadding.toDouble(),
              horizontal: responsive.horizontalPadding.toDouble(),
            ),
            child: _buildStatistics(responsive),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollingBrands(ResponsiveValues responsive) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double brandWidth = responsive.brandWidth.toDouble();
        final double totalBrandsWidth = brandWidth * brands.length;
        
        // Calculate scroll offset
        final double scrollOffset = _scrollAnimation.value * (totalBrandsWidth + brandWidth);
        
        return ClipRect(
          child: OverflowBox(
            maxWidth: double.infinity,
            child: Transform.translate(
              offset: Offset(-scrollOffset, 0),
              child: Row(
                children: [
                  // First set of brands
                  ...brands.map((brand) => _buildBrandItem(brand, responsive)),
                  // Duplicate set for seamless loop
                  ...brands.map((brand) => _buildBrandItem(brand, responsive)),
                  // Extra brand to ensure smooth transition
                  _buildBrandItem(brands.first, responsive),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandItem(BrandData brand, ResponsiveValues responsive) {
    return Container(
      width: responsive.brandWidth.toDouble(),
      height: responsive.brandHeight.toDouble(),
      margin: EdgeInsets.symmetric(horizontal: responsive.brandMargin.toDouble()),
      child: Center(
        child: Image.asset(
          brand.logo,
          height: responsive.logoHeight.toDouble(),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback text if image doesn't exist
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                brand.name,
                style: TextStyle(
                  fontSize: responsive.logoHeight * 0.25,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4A5568),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatistics(ResponsiveValues responsive) {
    final stats = [
      StatData('55+', 'years of experience'),
      StatData('10,000+', 'applications received'),
      StatData('\$49M+', 'in scholarships'),
      StatData('99%', 'success rate'),
    ];

    if (responsive.statColumns == 2) {
      // Mobile layout: 2x2 grid
      return Column(
        children: [
          Row(
            children: stats.take(2).map((stat) => 
              Expanded(child: _buildStatItem(stat, responsive))
            ).toList(),
          ),
          SizedBox(height: responsive.verticalPadding * 0.5),
          Row(
            children: stats.skip(2).map((stat) => 
              Expanded(child: _buildStatItem(stat, responsive))
            ).toList(),
          ),
        ],
      );
    } else {
      // Tablet and Desktop layout: single row
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.map((stat) => 
          Expanded(child: _buildStatItem(stat, responsive))
        ).toList(),
      );
    }
  }

  Widget _buildStatItem(StatData stat, ResponsiveValues responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.brandMargin.toDouble()),
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              stat.number,
              style: TextStyle(
                fontSize: responsive.statNumberFontSize.toDouble(),
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stat.label,
            style: TextStyle(
              fontSize: responsive.statLabelFontSize.toDouble(),
              fontWeight: FontWeight.w400,
              color: const Color(0xFFE2E8F0),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Enums and data classes for responsive design
enum ScreenSize { mobile, tablet, desktop }

class ResponsiveValues {
  final int titleFontSize;
  final int verticalPadding;
  final int horizontalPadding;
  final int brandHeight;
  final int brandWidth;
  final int brandMargin;
  final int logoHeight;
  final int statNumberFontSize;
  final int statLabelFontSize;
  final int statColumns;
  final int titleMaxLines;

  ResponsiveValues({
    required this.titleFontSize,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.brandHeight,
    required this.brandWidth,
    required this.brandMargin,
    required this.logoHeight,
    required this.statNumberFontSize,
    required this.statLabelFontSize,
    required this.statColumns,
    required this.titleMaxLines,
  });
}

class BrandData {
  final String name;
  final String logo;

  BrandData({
    required this.name,
    required this.logo,
  });
}

class StatData {
  final String number;
  final String label;

  StatData(this.number, this.label);
}