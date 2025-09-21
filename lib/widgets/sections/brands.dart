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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // White section with title and brands
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Column(
              children: [
                // Title
                const Text(
                  'Our applicants have been admitted to',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3748),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                
                // Scrolling brands
                SizedBox(
                  height: 120,
                  child: AnimatedBuilder(
                    animation: _scrollAnimation,
                    builder: (context, child) {
                      return _buildScrollingBrands();
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
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: _buildStatistics(),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollingBrands() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double _ = constraints.maxWidth;
        final double brandWidth = 280; // Width of each brand container
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
                  ...brands.map((brand) => _buildBrandItem(brand)),
                  // Duplicate set for seamless loop
                  ...brands.map((brand) => _buildBrandItem(brand)),
                  // Extra brand to ensure smooth transition
                  _buildBrandItem(brands.first),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandItem(BrandData brand) {
    return Container(
      width: 280,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Image.asset(
          brand.logo,
          height: 80,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback text if image doesn't exist
            return Text(
              brand.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A5568),
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('55+', 'years of experience'),
          _buildStatItem('10,000+', 'applications received'),
          _buildStatItem('\$49M+', 'in scholarships'),
          _buildStatItem('99%', 'success rate'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFFE2E8F0),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BrandData {
  final String name;
  final String logo;

  BrandData({
    required this.name,
    required this.logo,
  });
}