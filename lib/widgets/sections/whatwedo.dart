import 'package:flutter/material.dart';

class WhatWeDoSection extends StatefulWidget {
  const WhatWeDoSection({super.key});

  @override
  State<WhatWeDoSection> createState() => _WhatWeDoSectionState();
}

class _WhatWeDoSectionState extends State<WhatWeDoSection> {
  int activeStep = 1;

  // Step content data
  final Map<int, Map<String, String>> stepContent = {
    1: {
      'title': 'Profile Analysis',
      'description': 'We conduct a comprehensive analysis of your professional profile, examining your skills, experience, and career trajectory to understand your unique value proposition in the market.',
    },
    2: {
      'title': 'Market Research',
      'description': 'Our team performs in-depth market research to identify trending opportunities, salary benchmarks, and industry demands that align with your profile and career goals.',
    },
    3: {
      'title': 'Strategy Development',
      'description': 'Based on our analysis, we develop a customized career strategy that outlines the best path forward, including skill development recommendations and target opportunities.',
    },
    4: {
      'title': 'Application Optimization',
      'description': 'We optimize your resume, cover letters, and professional profiles to ensure they effectively communicate your value and stand out to potential employers.',
    },
    5: {
      'title': 'Interview Preparation',
      'description': 'Our experts provide comprehensive interview coaching, including mock interviews, question preparation, and presentation skills to boost your confidence and performance.',
    },
    6: {
      'title': 'Ongoing Support',
      'description': 'We provide continuous support throughout your job search journey, offering guidance, feedback, and adjustments to your strategy as needed.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.white, // Changed to white background
      child: Column(
        children: [
          // Section Title
          Text(
            'What we do',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          
          // Steps Row or Mobile Navigation
          if (!isMobile)
            Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  final stepNumber = index + 1;
                  return Flexible(
                    child: _buildStep('Step $stepNumber', stepNumber == activeStep, stepNumber),
                  );
                }),
              ),
            )
          else
            _buildMobileNavigation(),
          
          const SizedBox(height: 40),
          
          // Combined Content Container
          Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA), // Light gray background for the content box
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: _buildStepContent(activeStep, isMobile),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button
          IconButton(
            onPressed: activeStep > 1
                ? () {
                    setState(() {
                      activeStep--;
                    });
                  }
                : null,
            icon: Icon(
              Icons.arrow_back_ios,
              color: activeStep > 1 ? Colors.black87 : Colors.grey[300],
            ),
            iconSize: 28,
          ),
          
          // Step Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Step $activeStep',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          
          // Next Button
          IconButton(
            onPressed: activeStep < 6
                ? () {
                    setState(() {
                      activeStep++;
                    });
                  }
                : null,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: activeStep < 6 ? Colors.black87 : Colors.grey[300],
            ),
            iconSize: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String stepText, bool isActive, int stepNumber) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeStep = stepNumber;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isActive ? Colors.black87 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? Colors.black87 : const Color(0xFFE5E5E5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isActive ? 0.15 : 0.05),
              blurRadius: isActive ? 12 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          stepText,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(int step, bool isMobile) {
    final content = stepContent[step]!;
    
    return Container(
      key: ValueKey(step),
      child: Column(
        children: [
          // Image container
          Container(
            width: double.infinity,
            height: isMobile ? 200 : 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: isMobile ? 40 : 60,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 12),
                Text(
                  'Image for Step $step',
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '(Replace with your image)',
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Title
          Text(
            content['title']!,
            style: TextStyle(
              fontSize: isMobile ? 22 : 28,
              fontFamily: 'The Seasons',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            content['description']!,
            style: TextStyle(
              fontFamily: 'Cinzel',
              fontSize: isMobile ? 14 : 16,
              color: Colors.black54,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}