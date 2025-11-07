import 'dart:async';

import 'package:consultancy_website/form.dart' show FormScreen;
import 'package:consultancy_website/widgets/navitemsdropdown/aboutdd.dart';
import 'package:consultancy_website/widgets/navitemsdropdown/resourcesdd.dart';
import 'package:consultancy_website/widgets/navitemsdropdown/servicesdd.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  final bool _isScrolled = false;

  OverlayEntry? _overlayEntry;
  String? _activeDropdown;
  String? _hoveredItem;

  Timer? _closeTimer;
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
    if (_isTransitioning) return;

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
    if (_isTransitioning) return;

    _cancelClose();

    if (_activeDropdown == menuType && _overlayEntry != null) {
      return;
    }

    _isTransitioning = true;
    _removeOverlay();

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
            GestureDetector(
              onTap: _removeOverlay,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: menuType == 'Services'
                  ? position.dx - 350
                  : position.dx - 50,
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
                      maxWidth: menuType == 'Services'
                          ? 900
                          : (MediaQuery.of(context).size.width > 768
                                ? 400
                                : 300),
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
          _isTransitioning = false;
        });
      }
    });
  }

  Widget _buildDropdownContent(String menuType) {
    switch (menuType) {
      case 'About Us':
        return const AboutUsMenu();
      case 'Resources':
        return const ResourcesMenu();
      case 'Services':
        return ServicesDropdown(onClose: _removeOverlay);
      default:
        return Container();
    }
  }

  void _navigateToPage(String pageRoute) {
    _removeOverlay();
    Navigator.pushReplacementNamed(context, pageRoute);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjusted breakpoints: mobile menu appears at 950px and below
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 950 && screenWidth <= 1200;
    final isMobile = screenWidth <= 950;

    return SlideTransition(
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
            horizontal: isDesktop ? 32 : (isTablet ? 20 : 16),
            vertical: isDesktop ? 18 : 15,
          ),
          child: Row(
            children: [
              _buildLogo(isDesktop, isTablet),
              const Spacer(),
              if (!isMobile) _buildDesktopNavigation(isDesktop, isTablet),
              if (isMobile) _buildMobileMenuButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isDesktop, bool isTablet) {
    final logoHeight = isDesktop ? 42.0 : (isTablet ? 37.0 : 35.0);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/'),
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/iqlogored.png',
              height: logoHeight,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopNavigation(bool isDesktop, bool isTablet) {
    final menuItems = [
      {'title': 'About Us', 'hasDropdown': true, 'route': null},
      {'title': 'Resources', 'hasDropdown': true, 'route': null},
      {'title': 'Services', 'hasDropdown': true, 'route': null},
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
            isTablet,
          ),
        ),
        SizedBox(width: isDesktop ? 20 : 12),
        _buildConsultButton(isDesktop, isTablet),
      ],
    );
  }

  Widget _buildNavItem(
    String title,
    bool hasDropdown,
    String? route,
    bool isDesktop,
    bool isTablet,
  ) {
    final GlobalKey buttonKey = GlobalKey();
    final isActive = _activeDropdown == title;
    final isHovered = _hoveredItem == title;

    // Compact spacing for tablet
    final horizontalPadding = isDesktop ? 8.0 : 4.0;
    final verticalPadding = isDesktop ? 12.0 : 10.0;
    final innerHorizontal = isDesktop ? 16.0 : 10.0;
    final fontSize = isDesktop ? 15.0 : 13.5;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                _navigateToPage(route);
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: innerHorizontal,
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
                      fontSize: fontSize,
                      fontWeight: FontWeight.w800,
                      color: (isActive || isHovered)
                          ? const Color(0xFFE53E3E)
                          : const Color(0xFF374151),
                    ),
                  ),
                  if (hasDropdown) ...[
                    const SizedBox(width: 3),
                    AnimatedRotation(
                      turns: isActive ? 0.5 : 0,
                      duration: const Duration(milliseconds: 150),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: isDesktop ? 18 : 16,
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

  Widget _buildConsultButton(bool isDesktop, bool isTablet) {
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
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return const FormScreen();
                    },
                  );
                },
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 28 : 20,
                    vertical: isDesktop ? 14 : 11,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: isDesktop ? 16 : 14,
                        color: Colors.white,
                      ),
                      SizedBox(width: isDesktop ? 8 : 6),
                      Text(
                        'Consult Now',
                        style: TextStyle(
                          fontFamily: 'The Seasons',
                          fontSize: isDesktop ? 15 : 13.5,
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
                      'Resources',
                      Icons.library_books_outlined,
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
              child: _buildConsultButton(false, false),
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
                Navigator.pop(context);
                _navigateToPage(route);
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
      case 'Resources':
        return ResourcesMenu.getMobileMenuItems();
      case 'Services':
        return ServicesDropdown.getMobileMenuItems();
      default:
        return [];
    }
  }
}
