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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.white, // Changed from gray to white
      child: Column(
        children: [
          // Section Title
          Text(
            'What we do',
            style: TextStyle(
              fontSize: 48,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          
          // Steps Row - Constrained to 800 width with closer spacing
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed from spaceAround to spaceBetween for closer spacing
              children: List.generate(6, (index) {
                final stepNumber = index + 1;
                return Flexible( // Added Flexible to ensure proper sizing
                  child: _buildStep('Step $stepNumber', stepNumber == activeStep, stepNumber),
                );
              }),
            ),
          ),
          
          const SizedBox(height: 80),
          
          // Content Section
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildStepContent(activeStep),
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
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Reduced horizontal padding
        margin: const EdgeInsets.symmetric(horizontal: 4), // Added small margin for spacing
        decoration: BoxDecoration(
          color: isActive ? Colors.black : const Color(0xFFE8E9EA),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive 
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha : 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
        ),
        child: Text(
          stepText,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 14, // Slightly reduced font size to fit better
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(int step) {
    final content = stepContent[step]!;
    
    return Container(
      key: ValueKey(step), // Important for AnimatedSwitcher
      child: Column(
        children: [
          // Image placeholder - constrained to 800 width
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Image for Step $step',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '(Replace with your image)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Title - constrained to 800 width
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              content['title']!,
              style: const TextStyle(
                fontSize: 32,
                fontFamily: 'The Seasons',
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Description - expanded to 1300 width
          Container(
            constraints: const BoxConstraints(maxWidth: 1300),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              content['description']!,
              style: const TextStyle(
                fontFamily: 'Cinzel',
                fontSize: 18,
                color: Colors.black54,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}