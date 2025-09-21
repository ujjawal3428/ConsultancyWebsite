import 'package:consultancy_website/widgets/custom_app_bar.dart';
import 'package:consultancy_website/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class Newsroom extends StatefulWidget {
  const Newsroom({super.key});

  @override
  State<Newsroom> createState() => _NewsroomState();
}

class _NewsroomState extends State<Newsroom> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Technology', 'Business', 'Innovation', 'Strategy'];
  
  final List<Map<String, dynamic>> _articles = [
    {
      'title': 'AI Revolution in Enterprise Solutions',
      'subtitle': 'How artificial intelligence is transforming business operations across industries',
      'category': 'Technology',
      'date': 'Sep 18, 2025',
      'readTime': '8 min',
      'featured': true,
      'author': 'Sarah Chen',
      'color': Colors.red,
    },
    {
      'title': 'Sustainable Business Practices',
      'subtitle': 'Building eco-friendly strategies for long-term growth and environmental responsibility',
      'category': 'Business',
      'date': 'Sep 15, 2025',
      'readTime': '6 min',
      'featured': false,
      'author': 'Michael Rodriguez',
      'color': Colors.red,
    },
    {
      'title': 'The Future of Remote Collaboration',
      'subtitle': 'Innovative tools and methodologies reshaping how teams work together',
      'category': 'Innovation',
      'date': 'Sep 12, 2025',
      'readTime': '5 min',
      'featured': false,
      'author': 'Emma Thompson',
      'color': Colors.red,
    },
    {
      'title': 'Data-Driven Decision Making',
      'subtitle': 'Leveraging analytics and insights to drive strategic business outcomes',
      'category': 'Strategy',
      'date': 'Sep 10, 2025',
      'readTime': '7 min',
      'featured': false,
      'author': 'David Kim',
      'color': Colors.red,
    },
    {
      'title': 'Cybersecurity in Digital Age',
      'subtitle': 'Protecting your business from evolving threats in the digital landscape',
      'category': 'Technology',
      'date': 'Sep 8, 2025',
      'readTime': '9 min',
      'featured': false,
      'author': 'Lisa Park',
      'color': Colors.red,
    },
    {
      'title': 'Blockchain Beyond Cryptocurrency',
      'subtitle': 'Exploring practical applications of blockchain technology in business',
      'category': 'Innovation',
      'date': 'Sep 5, 2025',
      'readTime': '6 min',
      'featured': false,
      'author': 'James Wilson',
      'color': Colors.red,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredArticles {
    if (_selectedCategory == 'All') return _articles;
    return _articles.where((article) => article['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildHeroBanner(context),
            _buildCategoryFilter(context),
            _buildArticlesSection(context),
            const SizedBox(height: 60),
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 768;

    return Container(
      width: double.infinity,
      height: isSmall ? 400 : 500,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFAFAFA), Color(0xFFF5F5F5), Color(0xFFF0F0F0), Color(0xFFEDEDED)],
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.3),
                  Colors.white.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 40, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'INSIGHTS & INNOVATIONS',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.7),
                        fontSize: isSmall ? 14 : 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Shaping Tomorrow\'s\nBusiness Landscape',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmall ? 32 : 48,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Colors.red, Color(0xFFFF6B6B)]),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Discover expert insights, industry trends, and strategic perspectives\nthat drive digital transformation and business excellence.',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.8),
                        fontSize: isSmall ? 16 : 18,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatCard('150+', 'Articles', Colors.red),
                        const SizedBox(width: 30),
                        _buildStatCard('50k+', 'Readers', Colors.black),
                        const SizedBox(width: 30),
                        _buildStatCard('25+', 'Experts', Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(number, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: Colors.black.withValues(alpha: 0.7), fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: Colors.white,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text('Browse by Category', style: TextStyle(color: Colors.black.withValues(alpha: 0.9), fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: _categories.map((category) {
                  final isSelected = category == _selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.white,
                        border: Border.all(color: isSelected ? Colors.red : Colors.black.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ] : [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticlesSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final filtered = _filteredArticles;
    final featured = filtered.where((a) => a['featured']).toList();
    final regular = filtered.where((a) => !a['featured']).toList();

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (featured.isNotEmpty) ...[
            Text('Featured Stories', style: TextStyle(color: Colors.black, fontSize: screenWidth < 600 ? 24 : 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ...featured.map((article) => _buildFeaturedCard(article, context)),
            const SizedBox(height: 50),
          ],
          Text('Latest Articles', style: TextStyle(color: Colors.black, fontSize: screenWidth < 600 ? 20 : 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          screenWidth > 768 ? _buildGrid(regular) : _buildList(regular),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(Map<String, dynamic> article, BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: isSmall ? _buildFeaturedMobile(article) : _buildFeaturedDesktop(article),
      ),
    );
  }

  Widget _buildFeaturedDesktop(Map<String, dynamic> article) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.withValues(alpha: 0.1), Colors.red.withValues(alpha: 0.05)]
              )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article_outlined, size: 80, color: Colors.red),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('FEATURED', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(15)),
                    child: Text(article['category'], style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 16),
                  Text(article['title'], style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold, height: 1.3)),
                  const SizedBox(height: 12),
                  Text(article['subtitle'], style: TextStyle(color: Colors.black.withValues(alpha: 0.7), fontSize: 16, height: 1.5)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red.withValues(alpha: 0.1),
                        child: Text(article['author'].substring(0, 1), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(article['author'], style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
                          Text('${article['date']} • ${article['readTime']}', style: TextStyle(color: Colors.black.withValues(alpha: 0.6), fontSize: 12)),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 3,
                        ),
                        child: const Text('Read More', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedMobile(Map<String, dynamic> article) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.withValues(alpha: 0.1), Colors.red.withValues(alpha: 0.05)]
            )
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.article_outlined, size: 60, color: Colors.red),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text('FEATURED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                  child: Text(article['category'], style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 12),
                Text(article['title'], style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold, height: 1.3)),
                const SizedBox(height: 8),
                Text(article['subtitle'], style: TextStyle(color: Colors.black.withValues(alpha: 0.7), fontSize: 14, height: 1.5)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.red.withValues(alpha: 0.1),
                      child: Text(article['author'].substring(0, 1), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(article['author'], style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600)),
                          Text('${article['date']} • ${article['readTime']}', style: TextStyle(color: Colors.black.withValues(alpha: 0.6), fontSize: 10)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                      ),
                      child: const Text('Read', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(List<Map<String, dynamic>> articles) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.85, crossAxisSpacing: 20, mainAxisSpacing: 20),
      itemCount: articles.length,
      itemBuilder: (context, index) => _buildCard(articles[index]),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> articles) {
    return Column(children: articles.map((article) => Container(margin: const EdgeInsets.only(bottom: 20), child: _buildCard(article, isMobile: true))).toList());
  }

  Widget _buildCard(Map<String, dynamic> article, {bool isMobile = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: isMobile ? 150 : 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.withValues(alpha: 0.1), Colors.red.withValues(alpha: 0.05)]
                )
              ),
              child: Stack(
                children: [
                  Center(child: Icon(Icons.lightbulb_outline, size: isMobile ? 50 : 60, color: Colors.red)),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(article['category'], style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article['title'], style: TextStyle(color: Colors.black, fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 8),
                      Expanded(child: Text(article['subtitle'], style: TextStyle(color: Colors.black.withValues(alpha: 0.7), fontSize: isMobile ? 12 : 14, height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red.withValues(alpha: 0.1),
                            child: Text(article['author'].substring(0, 1), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(article['author'], style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                                Text(article['readTime'], style: TextStyle(color: Colors.black.withValues(alpha: 0.6), fontSize: 10)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(article['date'], style: TextStyle(color: Colors.black.withValues(alpha: 0.5), fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}