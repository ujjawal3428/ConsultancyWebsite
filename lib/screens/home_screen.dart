import 'package:consultancy_website/widgets/footer_widget.dart' show FooterSection;
import 'package:consultancy_website/widgets/sections/blogs.dart';
import 'package:consultancy_website/widgets/sections/brands.dart';
import 'package:consultancy_website/widgets/sections/findyourpath.dart';
import 'package:consultancy_website/widgets/sections/hero_section.dart';
import 'package:consultancy_website/widgets/sections/testimonials.dart';
import 'package:consultancy_website/widgets/sections/whatwedo.dart';
import 'package:consultancy_website/widgets/sections/whychooseus.dart';
import 'package:flutter/material.dart';
import '../custom_app_bar.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(),
              HeroSection(),
              FindYourPathSection(),
              BrandsSection(),
              WhyChooseUsSection(),
              WhatWeDoSection(),
              TestimonialCarousel(),
              BlogSection(),
              FooterSection(),
              // Future sections will be added here
              // ServicesSection(),
              // AboutSection(),
              // ContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}