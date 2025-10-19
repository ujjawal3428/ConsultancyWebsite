import 'package:flutter/material.dart';

// Import your models
// import 'package:consultancy_website/models/college_model.dart';

// Uncomment the import above and use these widgets

/// Widget to display individual college information cards in the grid
class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final String subvalue;
  final Color color;
  final IconData icon;

  const InfoCard({
    required this.label,
    required this.value,
    required this.subvalue,
    required this.color,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 24, color: color),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                subvalue,
                style: TextStyle(
                  fontSize: 11,
                  color: color.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Widget displaying the empty state when no college is selected
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 80, color: const Color(0xFFE5E7EB)),
            const SizedBox(height: 16),
            const Text(
              'Select a college to view details',
              style: TextStyle(fontSize: 16, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget for FAQ item with expandable functionality
class FAQItem extends StatelessWidget {
  final String question;

  const FAQItem({
    required this.question,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.help, size: 16, color: Colors.red),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              question,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ),
          Icon(Icons.arrow_forward, size: 18, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}