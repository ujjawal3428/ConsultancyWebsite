import 'package:flutter/material.dart';

class WhyChooseUsSection extends StatelessWidget {
  const WhyChooseUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.grey[50],
      child: Column(
        children: [
          // Title and Subtitle
          Column(
            children: [
              Text(
                'Why Choose Us?',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Unlocking the secret to your success',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 60),
          
          // Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive grid based on screen width
              if (constraints.maxWidth > 1200) {
                return _buildDesktopGrid();
              } else if (constraints.maxWidth > 768) {
                return _buildTabletGrid();
              } else {
                return _buildMobileGrid();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              children: [
                Expanded(child: _buildCard1()),
                const SizedBox(width: 20),
                Expanded(child: _buildCard2()),
                const SizedBox(width: 20),
                Expanded(child: _buildCard3()),
                const SizedBox(width: 20),
                Expanded(child: _buildCard4()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildCard1()),
            const SizedBox(width: 20),
            Expanded(child: _buildCard2()),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildCard3()),
            const SizedBox(width: 20),
            Expanded(child: _buildCard4()),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileGrid() {
    return Column(
      children: [
        _buildCard1(),
        const SizedBox(height: 20),
        _buildCard2(),
        const SizedBox(height: 20),
        _buildCard3(),
        const SizedBox(height: 20),
        _buildCard4(),
      ],
    );
  }

  Widget _buildCard1() {
    return _buildServiceCard(
      imagePath: 'assets/images/founders.png',
      title: '20 COMPELLING\nREASONS',
      subtitle: 'Why choose us',
      backgroundColor: Colors.orange[700]!,
      height: 300,
    );
  }

  Widget _buildCard2() {
    return _buildServiceCard(
      imagePath: 'assets/images/founders.png',
      title: 'Working with The IQ Admit\nPostgraduate Team',
      subtitle: '',
      backgroundColor: Color(0xFF4A5568),
      height: 300,
    );
  }

  Widget _buildCard3() {
    return _buildServiceCard(
      imagePath: 'assets/images/founders.png',
      title: 'Working with The IQ Admit\nUndergraduate Team',
      subtitle: '',
      backgroundColor: Colors.black87,
      height: 300,
    );
  }

  Widget _buildCard4() {
    return _buildServiceCard(
      imagePath: 'assets/images/founders.png',
      title: 'Working with The IQ Admit\nMBA Admissions Team',
      subtitle: '',
      backgroundColor: Color(0xFF2D3748),
      height: 300,
    );
  }

  Widget _buildServiceCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required double height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha : 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[600],
                    size: 50,
                  ),
                );
              },
            ),
            
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    backgroundColor.withValues(alpha : 0.8),
                    backgroundColor,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
            
            // Text Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    if (subtitle.isNotEmpty) const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // The Red Pen Logo (top-left corner)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'THE ',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'IQ',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      'Admit',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Hover Effect
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // Handle card tap
                },
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}