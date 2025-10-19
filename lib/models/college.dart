import 'package:flutter/material.dart';

/// Model representing a college with all its attributes
class College {
  final int id;
  final String name;
  final String state;
  final String city;
  final IconData logo;
  final String description;
  final String type;
  final String admissionDeadline;
  final int duration;

  College({
    required this.id,
    required this.name,
    required this.state,
    required this.city,
    required this.logo,
    required this.description,
    required this.type,
    required this.admissionDeadline,
    required this.duration,
  });
}

/// Static data repository containing all colleges organized by category and degree
class CollegeData {
  static final Map<String, Map<String, List<College>>> data = {
    'medical': {
      'MBBS': [
        College(
          id: 1,
          name: 'All India Institute of Medical Sciences',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.local_hospital,
          description: 'Premier medical institution offering MBBS with world-class facilities.',
          type: 'Government',
          admissionDeadline: '31-OCT-2025',
          duration: 36,
        ),
        College(
          id: 2,
          name: 'Nalanda Medical College',
          state: 'Bihar',
          city: 'Nalanda',
          logo: Icons.local_hospital,
          description: 'Established medical college with strong clinical training programs.',
          type: 'Government',
          admissionDeadline: '15-NOV-2025',
          duration: 36,
        ),
      ],
      'BDS': [
        College(
          id: 3,
          name: 'Bihar Dental College',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.medical_services,
          description: 'State-of-the-art dental college with modern laboratories.',
          type: 'Government',
          admissionDeadline: '30-OCT-2025',
          duration: 24,
        ),
      ],
    },
    'engineering': {
      'B.Tech': [
        College(
          id: 4,
          name: 'National Institute of Technology',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.engineering,
          description: 'Leading engineering institute with industry partnerships.',
          type: 'Government',
          admissionDeadline: '31-DEC-2025',
          duration: 48,
        ),
      ],
    },
    'commerce': {
      'B.Com': [
        College(
          id: 5,
          name: 'Institute of Commerce Studies',
          state: 'Uttar Pradesh',
          city: 'Lucknow',
          logo: Icons.attach_money,
          description: 'Premier commerce college with excellent faculty.',
          type: 'Government',
          admissionDeadline: '20-NOV-2025',
          duration: 36,
        ),
      ],
    },
    'law': {
      'B.Law': [
        College(
          id: 6,
          name: 'National Law University',
          state: 'Uttar Pradesh',
          city: 'Lucknow',
          logo: Icons.gavel,
          description: 'Prestigious law school producing top legal professionals.',
          type: 'Government',
          admissionDeadline: '15-DEC-2025',
          duration: 36,
        ),
      ],
    },
    'mba': {
      'MBA': [
        College(
          id: 7,
          name: 'Institute of Management Studies',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.business_center,
          description: 'Business school with strong placement record.',
          type: 'Private',
          admissionDeadline: '28-FEB-2025',
          duration: 24,
        ),
      ],
    },
    'bca': {
      'BCA': [
        College(
          id: 8,
          name: 'Institute of Technology',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.computer,
          description: 'Computer science college with industry-relevant curriculum.',
          type: 'Private',
          admissionDeadline: '31-JAN-2025',
          duration: 36,
        ),
      ],
    },
    'arts': {
      'B.A': [
        College(
          id: 9,
          name: 'Central Arts College',
          state: 'Bihar',
          city: 'Patna',
          logo: Icons.school,
          description: 'Liberal arts institution fostering critical thinking.',
          type: 'Government',
          admissionDeadline: '25-OCT-2025',
          duration: 36,
        ),
      ],
    },
    'science': {
      'B.Sc': [
        College(
          id: 10,
          name: 'Institute of Pure Sciences',
          state: 'Uttar Pradesh',
          city: 'Lucknow',
          logo: Icons.science,
          description: 'Science college with advanced research facilities.',
          type: 'Government',
          admissionDeadline: '30-OCT-2025',
          duration: 36,
        ),
      ],
    },
  };
}

/// Configuration for each category with title, icon, and color
class CategoryConfig {
  static final Map<String, Map<String, dynamic>> config = {
    'medical': {'title': 'Medical', 'icon': Icons.local_hospital, 'color': const Color(0xFFEF4444)},
    'engineering': {'title': 'Engineering', 'icon': Icons.engineering, 'color': const Color(0xFF3B82F6)},
    'commerce': {'title': 'Commerce', 'icon': Icons.attach_money, 'color': const Color(0xFF10B981)},
    'law': {'title': 'Law', 'icon': Icons.gavel, 'color': const Color(0xFF8B5CF6)},
    'mba': {'title': 'MBA', 'icon': Icons.business_center, 'color': const Color(0xFFF59E0B)},
    'bca': {'title': 'BCA', 'icon': Icons.computer, 'color': const Color(0xFF06B6D4)},
    'arts': {'title': 'Arts', 'icon': Icons.school, 'color': const Color(0xFF6366F1)},
    'science': {'title': 'Science', 'icon': Icons.science, 'color': const Color(0xFFEC4899)},
  };
}