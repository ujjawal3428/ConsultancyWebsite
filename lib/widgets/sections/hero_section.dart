import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _imageController;
  late AnimationController _floatingController;
  
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _imageController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.elasticOut,
    ));

    _imageScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.elasticOut,
    ));

    _floatingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    Future.delayed(const Duration(milliseconds: 300), () {
      _textController.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 600), () {
      _imageController.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 1000), () {
      _floatingController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _imageController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFD32F2F).withValues(alpha : 0.03),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background decoration
          _buildBackgroundDecoration(),
          
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 60,
              vertical: isMobile ? 40 : 80,
            ),
            child: isMobile
                ? _buildMobileLayout()
                : _buildDesktopLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecoration() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Floating circles
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Positioned(
                top: 100 + (20 * _floatingAnimation.value),
                right: 50,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD32F2F).withValues(alpha : 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: 150 - (15 * _floatingAnimation.value),
                left: 80,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5722).withValues(alpha : 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          // Geometric shapes
          Positioned(
            top: 50,
            left: 100,
            child: Transform.rotate(
              angle: 0.2,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFD32F2F).withValues(alpha : 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 5,
          child: _buildImageContent(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildImageContent(),
        const SizedBox(height: 40),
        _buildTextContent(),
      ],
    );
  }

  Widget _buildTextContent() {
    return SlideTransition(
      position: _textSlideAnimation,
      child: FadeTransition(
        opacity: _textFadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFD32F2F).withValues(alpha : 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Educational Excellence',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFD32F2F),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Main heading
            Text(
              'Transform Your',
              style: TextStyle(
                fontFamily: 'Cinzel',
                fontSize: MediaQuery.of(context).size.width < 768 ? 32 : 48,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
                height: 1.2,
              ),
            ),
            
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Academic ',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontSize: MediaQuery.of(context).size.width < 768 ? 32 : 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD32F2F),
                      height: 1.2,
                    ),
                  ),
                  TextSpan(
                    text: 'Journey',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontSize: MediaQuery.of(context).size.width < 768 ? 32 : 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Description
            Text(
              'Expert guidance for undergraduate admissions, postgraduate applications, and comprehensive educational consulting. Your success is our mission.',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                color: const Color(0xFF666666),
                height: 1.6,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Action buttons
            Row(
              children: [
                _buildPrimaryButton(),
                const SizedBox(width: 16),
                _buildSecondaryButton(),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Stats row
            _buildStatsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD32F2F).withValues(alpha : 0.4),
                  offset: const Offset(0, 8),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecondaryButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD32F2F),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 14,
            ),
            child: Text(
              'Learn More',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: const Color(0xFFD32F2F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatItem('500+', 'Students Guided'),
        const SizedBox(width: 40),
        _buildStatItem('98%', 'Success Rate'),
        const SizedBox(width: 40),
        _buildStatItem('10+', 'Years Experience'),
      ],
    );
  }

 Widget _buildStatItem(String number, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        number,
        style: const TextStyle(
          fontSize: 24,
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          color: Color(0xFFD32F2F),
        ),
      ),
      SizedBox(
        width: 80, // adjust as needed for mobile layout
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildImageContent() {
    return AnimatedBuilder(
      animation: _imageScaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _imageScaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD32F2F).withValues(alpha : 0.2),
                  offset: const Offset(0, 20),
                  blurRadius: 40,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Main illustration container
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFD32F2F).withValues(alpha : 0.1),
                        const Color(0xFFFF5722).withValues(alpha : 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD32F2F),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD32F2F).withValues(alpha : 0.3),
                                offset: const Offset(0, 10),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Excellence in Education',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2C2C2C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Floating elements
                AnimatedBuilder(
                  animation: _floatingAnimation,
                  builder: (context, child) {
                    return Positioned(
                      top: 50 + (10 * _floatingAnimation.value),
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha : 0.1),
                              offset: const Offset(0, 4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.trending_up,
                          color: Color(0xFFD32F2F),
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
                
                AnimatedBuilder(
                  animation: _floatingAnimation,
                  builder: (context, child) {
                    return Positioned(
                      bottom: 80 - (15 * _floatingAnimation.value),
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha : 0.1),
                              offset: const Offset(0, 4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lightbulb_outline,
                          color: Color(0xFFFF5722),
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}