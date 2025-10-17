import 'dart:async';

import 'package:consultancy_website/form.dart' show FormScreen;
import 'package:consultancy_website/widgets/navitemsdropdown/aboutdd.dart';
import 'package:consultancy_website/widgets/navitemsdropdown/resourcesdd.dart';
import 'package:consultancy_website/widgets/navitemsdropdown/servicesdd.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  final bool _isScrolled = false;

  // Overlay controllers for dropdown menus
  OverlayEntry? _overlayEntry;
  String? _activeDropdown;
  String? _hoveredItem;

  // Timer for delayed closing - increased delay to prevent flicker
  Timer? _closeTimer;

  // Add a flag to prevent rapid state changes
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _slideController.forward();
  }

  @override
  void dispose() {
    _closeTimer?.cancel();
    _removeOverlay();
    _slideController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    if (_isTransitioning) return; // Prevent multiple calls

    _closeTimer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _activeDropdown = null;
      _hoveredItem = null;
    });
  }

  void _scheduleClose() {
    _closeTimer?.cancel();
    // Increased delay to prevent flicker when moving between nav item and dropdown
    _closeTimer = Timer(const Duration(milliseconds: 200), () {
      if (_hoveredItem == null || _hoveredItem != _activeDropdown) {
        _removeOverlay();
      }
    });
  }

  void _cancelClose() {
    _closeTimer?.cancel();
  }

  void _showDropdownMenu(String menuType, GlobalKey buttonKey) {
    if (_isTransitioning) return; // Prevent rapid transitions

    _cancelClose();

    // If the same dropdown is already open, don't recreate it
    if (_activeDropdown == menuType && _overlayEntry != null) {
      return;
    }

    _isTransitioning = true;
    _removeOverlay();

    // Add a small delay before showing new dropdown to prevent flicker
    Future.delayed(const Duration(milliseconds: 50), () {
      if (!mounted) return;

      final RenderBox? renderBox =
          buttonKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) {
        _isTransitioning = false;
        return;
      }

      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            // Invisible barrier to close dropdown - but only on click, not hover
            GestureDetector(
              onTap: _removeOverlay,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
              ),
            ),
            // Dropdown menu with hover detection
            Positioned(
              left: position.dx - 50,
              top: position.dy + size.height + 5,
              child: MouseRegion(
                onEnter: (_) {
                  _cancelClose();
                  if (mounted) {
                    setState(() {
                      _hoveredItem = menuType;
                    });
                  }
                },
                onExit: (_) {
                  if (mounted) {
                    setState(() {
                      _hoveredItem = null;
                    });
                  }
                  _scheduleClose();
                },
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(16),
                  shadowColor: Colors.black.withValues(alpha: 0.1),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width > 768
                          ? 400
                          : 300,
                      maxHeight: 500,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: _buildDropdownContent(menuType),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      if (mounted) {
        Overlay.of(context).insert(_overlayEntry!);
        setState(() {
          _activeDropdown = menuType;
        });
      }

      _isTransitioning = false;
    });
  }

  Widget _buildDropdownContent(String menuType) {
    switch (menuType) {
      case 'About Us':
        return const AboutUsMenu();
      case 'Services':
        return const ServicesMenu();
      case 'Resources':
        return const ResourcesMenu();
      default:
        return Container();
    }
  }

  // Navigation function for non-dropdown items
  void _navigateToPage(String pageRoute) {
    // Close any open dropdowns first
    _removeOverlay();

    // Navigate to the specified route
    Navigator.pushNamed(context, pageRoute);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;

    // The Stack widget is the new parent for Positioned
    return SizedBox(
      child: Stack(
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: _isScrolled
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          offset: const Offset(0, 2),
                          blurRadius: 12,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          offset: const Offset(0, 1),
                          blurRadius: 4,
                        ),
                      ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 32 : (isTablet ? 24 : 16),
                  vertical: isDesktop ? 18 : 15,
                ),
                child: Row(
                  children: [
                    _buildLogo(isDesktop, isTablet),
                    const Spacer(),
                    if (!isMobile) _buildDesktopNavigation(isDesktop),
                    if (isMobile) _buildMobileMenuButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(bool isDesktop, bool isTablet) {
    final logoSize = isDesktop ? 45.0 : (isTablet ? 42.0 : 38.0);
    final titleSize = isDesktop ? 22.0 : (isTablet ? 20.0 : 18.0);
    final subtitleSize = isDesktop ? 15.0 : (isTablet ? 14.0 : 12.0);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/'),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Container(
                  width: logoSize,
                  height: logoSize,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE53E3E), Color(0xFFD53F8C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE53E3E).withValues(alpha: 0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.psychology_outlined,
                    color: Colors.white,
                    size: logoSize * 0.6,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'IQAdmit',
                      style: TextStyle(
                        fontFamily: 'The Seasons',
                        fontSize: titleSize,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Pro',
                      style: TextStyle(
                        fontFamily: 'The Seasons',
                        fontSize: subtitleSize,
                        color: const Color(0xFFE53E3E),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopNavigation(bool isDesktop) {
    final menuItems = [
      {'title': 'About Us', 'hasDropdown': true, 'route': null},
      {'title': 'Services', 'hasDropdown': true, 'route': null},
      {'title': 'Resources', 'hasDropdown': true, 'route': null},
      {'title': 'Events', 'hasDropdown': false, 'route': '/events'},
      {'title': 'Newsroom', 'hasDropdown': false, 'route': '/newsroom'},
      {'title': 'Shop', 'hasDropdown': false, 'route': '/shop'},
    ];

    return Row(
      children: [
        ...menuItems.map(
          (item) => _buildNavItem(
            item['title'] as String,
            item['hasDropdown'] as bool,
            item['route'] as String?,
            isDesktop,
          ),
        ),
        SizedBox(width: isDesktop ? 24 : 16),
        _buildConsultButton(isDesktop),
      ],
    );
  }

  Widget _buildNavItem(
    String title,
    bool hasDropdown,
    String? route,
    bool isDesktop,
  ) {
    final GlobalKey buttonKey = GlobalKey();
    final isActive = _activeDropdown == title;
    final isHovered = _hoveredItem == title;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 8 : 6),
      child: Material(
        color: Colors.transparent,
        child: MouseRegion(
          onEnter: (_) {
            if (mounted && !_isTransitioning) {
              setState(() {
                _hoveredItem = title;
              });
              if (hasDropdown) {
                _cancelClose();
                _showDropdownMenu(title, buttonKey);
              }
            }
          },
          onExit: (_) {
            if (mounted && !_isTransitioning) {
              // Only clear hover state if we're not hovering over the dropdown
              if (_activeDropdown != title) {
                setState(() {
                  _hoveredItem = null;
                });
              }
              if (hasDropdown) {
                _scheduleClose();
              }
            }
          },
          child: InkWell(
            key: hasDropdown ? buttonKey : null,
            onTap: () {
              if (hasDropdown && !_isTransitioning) {
                if (isActive) {
                  _removeOverlay();
                } else {
                  _showDropdownMenu(title, buttonKey);
                }
              } else if (!hasDropdown && route != null) {
                // Navigate to the specified route for non-dropdown items
                _navigateToPage(route);
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 150,
              ), // Reduced animation duration
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: isDesktop ? 16 : 12,
              ),
              decoration: BoxDecoration(
                color: (isActive || isHovered)
                    ? const Color(0xFFE53E3E).withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'The Seasons',
                      fontSize: isDesktop ? 15 : 14,
                      fontWeight: FontWeight.w800,
                      color: (isActive || isHovered)
                          ? const Color(0xFFE53E3E)
                          : const Color(0xFF374151),
                    ),
                  ),
                  if (hasDropdown) ...[
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: isActive ? 0.5 : 0,
                      duration: const Duration(
                        milliseconds: 150,
                      ), // Reduced animation duration
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: (isActive || isHovered)
                            ? const Color(0xFFE53E3E)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsultButton(bool isDesktop) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE53E3E), Color(0xFFC53030)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE53E3E).withValues(alpha: 0.4),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true, // User can tap outside to close
                    builder: (BuildContext context) {
                      return const FormScreen();
                    },
                  );
                },
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 28 : 24,
                    vertical: isDesktop ? 14 : 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: isDesktop ? 16 : 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Consult Now',
                        style: TextStyle(
                          fontFamily: 'The Seasons',
                          fontSize: isDesktop ? 15 : 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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

  Widget _buildMobileMenuButton() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE53E3E).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {
          _showMobileMenu(context);
        },
        icon: const Icon(
          Icons.menu_rounded,
          color: Color(0xFFE53E3E),
          size: 24,
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildMobileMenuItem(
                      'About Us',
                      Icons.info_outline,
                      true,
                      null,
                    ),
                    _buildMobileMenuItem(
                      'Services',
                      Icons.work_outline,
                      true,
                      null,
                    ),
                    _buildMobileMenuItem(
                      'Resources',
                      Icons.library_books_outlined,
                      true,
                      null,
                    ),
                    _buildMobileMenuItem(
                      'Events',
                      Icons.event_outlined,
                      false,
                      '/events',
                    ),
                    _buildMobileMenuItem(
                      'Newsroom',
                      Icons.newspaper_outlined,
                      false,
                      '/newsroom',
                    ),
                    _buildMobileMenuItem(
                      'Shop',
                      Icons.shopping_bag_outlined,
                      false,
                      '/shop',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: _buildConsultButton(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(
    String title,
    IconData icon,
    bool hasSubMenu,
    String? route,
  ) {
    return ExpansionTile(
      leading: Icon(icon, color: const Color(0xFFE53E3E), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'The Seasons',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF374151),
        ),
      ),
      onExpansionChanged: !hasSubMenu
          ? (expanded) {
              if (!expanded && route != null) {
                Navigator.pop(context); // Close the bottom sheet
                _navigateToPage(route); // Navigate to the page
              }
            }
          : null,
      trailing: hasSubMenu
          ? const Icon(Icons.expand_more)
          : const Icon(Icons.arrow_forward_ios, size: 16),
      children: hasSubMenu ? _buildMobileSubMenu(title) : [],
    );
  }

  List<Widget> _buildMobileSubMenu(String menuType) {
    switch (menuType) {
      case 'About Us':
        return AboutUsMenu.getMobileMenuItems();
      case 'Services':
        return ServicesMenu.getMobileMenuItems(context);
      case 'Resources':
        return ResourcesMenu.getMobileMenuItems();
      default:
        return [];
    }
  }
}
