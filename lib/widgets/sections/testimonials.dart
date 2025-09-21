import 'package:flutter/material.dart';

class TestimonialCarousel extends StatefulWidget {
  const TestimonialCarousel({super.key});

  @override
  State<TestimonialCarousel> createState() => _TestimonialCarouselState();
}

class _TestimonialCarouselState extends State<TestimonialCarousel>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late PageController _pageController;
  
  final List<TestimonialData> testimonials = [
    TestimonialData(
      title: "HEC Paris | Class of 2021",
      content:
          "Recommended by a friend, I sought The Red Pen for MBA applications. Their support stood out, guiding me professionally with a personal touch. From understanding my goals to crafting applications, they invested in my growth. Genuine concern, perfectionist drafts, and candid feedback shaped a brilliant story. Their efficient approach persisted, building a powerful narrative through concise edits and direct LOR guidance. Worth every penny, HEC Paris became reality. The Red Pen acted as a dedicated mentor throughout my MBA journey. Grateful for their commitment!",
    ),
    TestimonialData(
      title: "Hong Kong University | Class of 2022",
      content:
          "I had enrolled my daughter with The Red Pen for overseas applications. My daughter had been assigned a counsellor, who helped us at every step of the way. At the end of the process, we had offers from 8 different universities including NTU Singapore, University of Hong Kong, ESSEC and University of St Andrews. My daughter finally joined HKU with a 50% scholarship. To sum up the experience, I found their approach extremely professional and it really helped my daughter pick the right university that suited her personality. I would highly recommend The Red Pen for counselling.",
    ),
    TestimonialData(
      title: "New York University | Class of 2020",
      content:
          "Starting my Master's applications, I was referred to The Red Pen by enthusiastic BCG colleagues. After an initial chat, I was confident I'd made the right choice. What set them apart was the personalized approach—my goals truly mattered. They transformed my application from ordinary to outstanding, showcasing my strategy background and aspirations for a sports management Master's. Despite lacking sports industry experience, my resume and SOP highlighted how my business skills translated. Thanks to their expertise, I gained admission to the world's top 5 sports programs. Grateful to The Red Pen for this transformative journey.",
    ),
    TestimonialData(
      title: "Stanford University | Class of 2023",
      content:
          "The Red Pen helped me secure admission to Stanford's MBA program. Their strategic approach and attention to detail made all the difference. The team understood my unique background and helped me craft compelling essays that showcased my leadership potential. The process was collaborative, and I felt supported throughout. Their expertise in understanding what top-tier schools look for is unmatched. I couldn't have achieved this dream without their guidance.",
    ),
    TestimonialData(
      title: "London Business School | Class of 2024",
      content:
          "Working with The Red Pen was a game-changer for my MBA application journey. They helped me identify my unique value proposition and articulated it beautifully across all application components. The team's deep understanding of European business schools and their requirements was evident throughout the process. Their feedback was always constructive and actionable. Thanks to their support, I not only got into LBS but also received a partial scholarship. Highly recommended for anyone serious about top MBA programs.",
    ),
    TestimonialData(
      title: "MIT Sloan | Class of 2022",
      content:
          "The Red Pen's expertise in STEM MBA applications is exceptional. As an engineer looking to transition into management consulting, they helped me bridge my technical background with my business aspirations. Their understanding of MIT Sloan's culture and values was crucial in crafting my application. The mock interview sessions were particularly valuable in preparing me for the admissions process. I'm now a proud Sloan alumnus, and I owe much of my success to The Red Pen's dedicated support and professional guidance.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _pageController = PageController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Responsive breakpoints
  int _getCardsToShow(double screenWidth) {
    if (screenWidth < 600) return 1; // Mobile
    if (screenWidth < 900) return 2; // Tablet
    return 3; // Desktop
  }

  int _getTotalPages(int cardsToShow) {
    return ((testimonials.length / cardsToShow).ceil()).clamp(1, testimonials.length);
  }

  void _nextSlide() {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardsToShow = _getCardsToShow(screenWidth);
    final totalPages = _getTotalPages(cardsToShow);
    
    if (_currentIndex < totalPages - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _prevSlide() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _goToSlide(int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardsToShow = _getCardsToShow(screenWidth);
    final totalPages = _getTotalPages(cardsToShow);
    
    setState(() {
      _currentIndex = index.clamp(0, totalPages - 1);
    });
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isLeft,
    required bool isMobile,
  }) {
    if (isMobile) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null 
              ? const Color(0xFFE74C3C) 
              : Colors.grey[400],
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
          elevation: 4,
        ),
        child: Icon(icon, size: 24),
      );
    }

    return Positioned(
      top: 0,
      bottom: 0,
      left: isLeft ? -20 : null,
      right: !isLeft ? -20 : null,
      child: Center(
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: onPressed != null ? const Color(0xFFE74C3C) : Colors.grey[400],
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha : 0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.white, size: 20),
            padding: EdgeInsets.zero,
            splashRadius: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildDotIndicators(int totalPages) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      children: List.generate(totalPages, (index) {
        return GestureDetector(
          onTap: () => _goToSlide(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: index == _currentIndex ? 24 : 12,
            height: 12,
            decoration: BoxDecoration(
              color: index == _currentIndex
                  ? const Color(0xFFE74C3C)
                  : Colors.grey[400],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTestimonialGrid(int cardsToShow, double availableWidth) {
    final startIndex = _currentIndex * cardsToShow;
    final endIndex = (startIndex + cardsToShow).clamp(0, testimonials.length);
    final currentTestimonials = testimonials.sublist(startIndex, endIndex);
    
    // Calculate card width with proper spacing
    double cardWidth;
    double spacing = 16.0;
    
    if (cardsToShow == 1) {
      cardWidth = availableWidth;
      spacing = 0;
    } else if (cardsToShow == 2) {
      cardWidth = (availableWidth - spacing) / 2;
    } else {
      cardWidth = (availableWidth - (2 * spacing)) / 3;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
      child: Container(
        key: ValueKey(_currentIndex),
        child: cardsToShow == 1
            ? TestimonialCard(
                testimonial: currentTestimonials.first,
                width: cardWidth,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: currentTestimonials.map((testimonial) {
                  final isLast = testimonial == currentTestimonials.last;
                  return Container(
                    width: cardWidth,
                    margin: EdgeInsets.only(right: isLast ? 0 : spacing),
                    child: TestimonialCard(testimonial: testimonial, width: cardWidth),
                  );
                }).toList(),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final cardsToShow = _getCardsToShow(screenWidth);
          final totalPages = _getTotalPages(cardsToShow);
          final isMobile = screenWidth < 600;
          
          // Adjust current index if needed
          if (_currentIndex >= totalPages) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _currentIndex = totalPages - 1;
              });
            });
          }

          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 60,
              horizontal: isMobile ? 16 : 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Section Title
                Column(
                  children: [
                    Text(
                      'Our Testimonials',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: isMobile ? 32 : 40,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF333333),
                        fontFamily: 'Crimson',
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 8),
                    Text(
                      'What our applicants have to say',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: isMobile ? 16 : 18,
                        color: const Color(0xFF666666),
                        fontFamily: 'Crimson',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 30 : 50),
                
                // Testimonial Carousel
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: isMobile ? 400 : 450,
                    maxHeight: isMobile ? 500 : 550,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Main Content
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 40),
                        child: _buildTestimonialGrid(cardsToShow, 
                            screenWidth - (isMobile ? 32 : 120)),
                      ),
                      
                      // Desktop Navigation Buttons
                      if (!isMobile && totalPages > 1) ...[
                        _buildNavigationButton(
                          icon: Icons.chevron_left,
                          onPressed: _currentIndex > 0 ? _prevSlide : null,
                          isLeft: true,
                          isMobile: false,
                        ),
                        _buildNavigationButton(
                          icon: Icons.chevron_right,
                          onPressed: _currentIndex < totalPages - 1 ? _nextSlide : null,
                          isLeft: false,
                          isMobile: false,
                        ),
                      ],
                    ],
                  ),
                ),
                
                if (totalPages > 1) ...[
                  SizedBox(height: isMobile ? 30 : 40),
                  
                  // Dot Indicators
                  _buildDotIndicators(totalPages),
                  
                  // Mobile Navigation Buttons
                  if (isMobile)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNavigationButton(
                            icon: Icons.chevron_left,
                            onPressed: _currentIndex > 0 ? _prevSlide : null,
                            isLeft: true,
                            isMobile: true,
                          ),
                          const SizedBox(width: 20),
                          _buildNavigationButton(
                            icon: Icons.chevron_right,
                            onPressed: _currentIndex < totalPages - 1 ? _nextSlide : null,
                            isLeft: false,
                            isMobile: true,
                          ),
                        ],
                      ),
                    ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final TestimonialData testimonial;
  final double width;

  const TestimonialCard({
    super.key,
    required this.testimonial,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = width < 300;
    
    return Container(
      width: width,
      constraints: BoxConstraints(
        minHeight: isMobile ? 400 : 450,
        maxHeight: isMobile ? 500 : 550,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              testimonial.title,
              style: TextStyle(
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C5AA0),
                fontFamily: 'Crimson',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: isMobile ? 20 : 25),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  testimonial.content,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: const Color(0xFF4A4A4A),
                    height: 1.6,
                    fontFamily: 'Crimson',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestimonialData {
  final String title;
  final String content;

  TestimonialData({
    required this.title,
    required this.content,
  });
}