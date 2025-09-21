import 'package:flutter/material.dart';

class ResourcesMenu extends StatelessWidget {
  const ResourcesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // fixed width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top red strip
          Container(
            height: 5,
            width: double.infinity,
            color: Colors.red,
          ),

          // Menu items
          Column(
            children: [
              _buildMenuItem("INK | Interactive Narrative Kit"),
              _buildMenuItem("Blogs"),
              _buildMenuItem("Videos"),
              _buildMenuItem("Why Choose Us"),
              _buildMenuItem("Work With Us"),
            ],
          ),

          // Bottom red strip
          Container(
            height: 5,
            width: double.infinity,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return _HoverText(title: title);
  }

  /// Mobile version menu items
  static List<Widget> getMobileMenuItems() {
    final items = [
      'INK | Interactive Narrative Kit',
      'Blogs',
      'Videos',
      'Why Choose Us',
      'Work With Us',
    ];

    return items.map((item) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('Mobile tapped: $item');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}

// Hover text widget
class _HoverText extends StatefulWidget {
  final String title;
  const _HoverText({required this.title});

  @override
  State<_HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<_HoverText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _isHovering ? Colors.red : const Color(0xFF374151),
          ),
        ),
      ),
    );
  }
}