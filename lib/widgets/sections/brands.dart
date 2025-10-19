import 'package:flutter/material.dart';

class BrandsSection extends StatefulWidget {
  const BrandsSection({super.key});

  @override
  State<BrandsSection> createState() => _BrandsSectionState();
}

class _BrandsSectionState extends State<BrandsSection> {
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
          brandHeight: 120,
          brandWidth: 240,
          brandMargin: 15,
          logoHeight: 80,
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
          brandHeight: 140,
          brandWidth: 280,
          brandMargin: 20,
          logoHeight: 100,
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
          brandHeight: 160,
          brandWidth: 320,
          brandMargin: 25,
          logoHeight: 120,
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
                
                // Scrollable brands
                SizedBox(
                  height: responsive.brandHeight.toDouble(),
                  child: _buildScrollableBrands(responsive),
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

  Widget _buildScrollableBrands(ResponsiveValues responsive) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: responsive.horizontalPadding.toDouble()),
      child: Row(
        children: brands.map((brand) => _buildBrandItem(brand, responsive)).toList(),
      ),
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