import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768;

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Main Footer Content
          Align(
            alignment: isDesktop ? Alignment.center : Alignment.centerLeft,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 60 : (isTablet ? 40 : 20),
                vertical: isDesktop ? 60 : 40,
              ),
              child: isDesktop
                  ? _buildDesktopLayout(context)
                  : _buildMobileLayout(context),
            ),
          ),
          // Bottom Section with Logo and Copyright
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                // Logo Section
                Row(
                  mainAxisAlignment: isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
                  children: [
                    // Main Logo
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'IQ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                              letterSpacing: 2,
                            ),
                          ),
                          TextSpan(
                            text: 'Admit',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Partnership Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'IN NEWS',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'In partnership with',
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                  textAlign: isDesktop ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(height: 30),
                // Company Info
                Text(
                  'Bale Education Country Pvt. Ltd. | ©The IQAdmit | 2025',
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  textAlign: isDesktop ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(height: 15),
                // Address
                Text(
                  'Corporate Office: Apartment #2828, Secret Wars, Junwani Road, Beti Road West, Maore Villa,\n Bhilai, 490001, Chhattisgarh | Number: +91 98383 87333',
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Colors.white60,
                    height: 1.5,
                  ),
                  textAlign: isDesktop ? TextAlign.center : TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Menu Section
        Expanded(flex: 2, child: _buildMenuSection()),
        const SizedBox(width: 60),
        // Services Section
        Expanded(flex: 3, child: _buildServicesSection()),
        const SizedBox(width: 60),
        // Resources Section
        Expanded(flex: 2, child: _buildResourcesSection()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMenuSection(),
        const SizedBox(height: 40),
        _buildServicesSection(),
        const SizedBox(height: 40),
        _buildResourcesSection(),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menu',
          style: TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 25),
        _buildFooterLink('Home'),
        _buildFooterLink('About Us'),
        _buildFooterLink('Contact Us'),
        _buildFooterLink('FAQs'),
        _buildFooterLink('Privacy Policy'),
        _buildFooterLink('Refunds & Terms'),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Services',
          style: TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 25),
        _buildFooterLink('Undergraduate Preparation'),
        _buildFooterLink('Boarding School Admissions'),
        _buildFooterLink('Undergraduate Admissions'),
        _buildFooterLink('Postgraduate Admissions'),
        _buildFooterLink('Education Counselling'),
        _buildFooterLink('MBA Admissions'),
      ],
    );
  }

  Widget _buildResourcesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Resources',
          style: TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 25),
        _buildFooterLink('Blogs'),
        _buildFooterLink('Events'),
        _buildFooterLink('Work with us'),
        const SizedBox(height: 25),
        // Social Media Icons
        Wrap(
          // ✅ USE A WRAP WIDGET INSTEAD OF A ROW
          spacing: 15, // Horizontal space between icons
          runSpacing: 15, // Vertical space if icons wrap to a new line
          children: [
            _buildSocialIcon(Icons.camera_alt, 'Instagram'),
            _buildSocialIcon(Icons.business, 'LinkedIn'),
            _buildSocialIcon(Icons.play_arrow, 'YouTube'),
            _buildSocialIcon(Icons.chat, 'WhatsApp'),
            _buildSocialIcon(Icons.phone, 'Phone'),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Handle navigation
        },
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String platform) {
    return InkWell(
      onTap: () {
        // Handle social media navigation
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white70),
        ),
        child: Icon(icon, size: 18, color: Colors.white70),
      ),
    );
  }
}