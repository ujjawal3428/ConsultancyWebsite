import 'package:consultancy_website/widgets/custom_app_bar.dart';
import 'package:consultancy_website/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Newsroom extends StatefulWidget {
  const Newsroom({super.key});

  @override
  State<Newsroom> createState() => _NewsroomState();
}

class _NewsroomState extends State<Newsroom> with TickerProviderStateMixin {
  String _selectedCategory = 'All';
  int _currentPage = 1;
  final int _articlesPerPage = 6;
  
  // Carousel variables
  late PageController _carouselController;
  late Timer _carouselTimer;
  int _currentCarouselIndex = 0;

  final List<String> _categories = ['All', 'Technology', 'Business', 'Innovation', 'Strategy'];
  
  // Carousel banner data
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'Digital Transformation Summit 2025',
      'subtitle': 'Join industry leaders in exploring the future of digital innovation',
      'image': 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
      'gradient': [Colors.blue, Colors.purple],
    },
    {
      'title': 'AI-Powered Business Solutions',
      'subtitle': 'Discover how artificial intelligence is revolutionizing modern enterprises',
      'image': 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
      'gradient': [Colors.red, Colors.orange],
    },
    {
      'title': 'Sustainable Innovation Conference',
      'subtitle': 'Building tomorrow\'s solutions with environmental responsibility',
      'image': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
      'gradient': [Colors.green, Colors.teal],
    },
  ];
  
  final List<Map<String, dynamic>> _articles = [
    {
      'title': 'AI Revolution in Enterprise Solutions',
      'subtitle': 'How artificial intelligence is transforming business operations across industries',
      'category': 'Technology',
      'date': 'Sep 18, 2025',
      'readTime': '8 min',
      'featured': false,
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
    {
      'title': 'Cloud Computing Strategies',
      'subtitle': 'Optimizing cloud infrastructure for scalable business growth',
      'category': 'Technology',
      'date': 'Sep 3, 2025',
      'readTime': '7 min',
      'featured': false,
      'author': 'Anna Martinez',
      'color': Colors.red,
    },
    {
      'title': 'Digital Marketing Evolution',
      'subtitle': 'Leveraging new technologies for effective customer engagement',
      'category': 'Business',
      'date': 'Sep 1, 2025',
      'readTime': '5 min',
      'featured': false,
      'author': 'Robert Taylor',
      'color': Colors.red,
    },
    {
      'title': 'IoT in Manufacturing',
      'subtitle': 'Internet of Things revolutionizing industrial processes and efficiency',
      'category': 'Innovation',
      'date': 'Aug 29, 2025',
      'readTime': '8 min',
      'featured': false,
      'author': 'Kevin Zhang',
      'color': Colors.red,
    },
    {
      'title': 'Agile Leadership Principles',
      'subtitle': 'Leading teams effectively in rapidly changing business environments',
      'category': 'Strategy',
      'date': 'Aug 27, 2025',
      'readTime': '6 min',
      'featured': false,
      'author': 'Sophie Brown',
      'color': Colors.red,
    },
  ];

  List<Map<String, dynamic>> get _filteredArticles {
    if (_selectedCategory == 'All') return _articles;
    return _articles.where((article) => article['category'] == _selectedCategory).toList();
  }

  List<Map<String, dynamic>> get _paginatedArticles {
    final filtered = _filteredArticles;
    final startIndex = (_currentPage - 1) * _articlesPerPage;
    final endIndex = startIndex + _articlesPerPage;
    return filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
  }

  int get _totalPages {
    return (_filteredArticles.length / _articlesPerPage).ceil();
  }

  @override
  void initState() {
    super.initState();
    _carouselController = PageController(initialPage: 0);
    _startCarouselTimer();
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  void _startCarouselTimer() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentCarouselIndex < _carouselItems.length - 1) {
        _currentCarouselIndex++;
      } else {
        _currentCarouselIndex = 0;
      }
      if (_carouselController.hasClients) {
        _carouselController.animateToPage(
          _currentCarouselIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
      _currentPage = 1; // Reset to first page when category changes
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildCarouselBanner(context),
            _buildCategoryFilter(context),
            _buildArticlesSection(context),
            _buildPagination(context),
            const SizedBox(height: 60),
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselBanner(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox(
      height: screenWidth > 768 ? 400 : 300,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: _carouselController,
            onPageChanged: (index) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
            itemCount: _carouselItems.length,
            itemBuilder: (context, index) {
              final item = _carouselItems[index];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      item['gradient'][0].withValues(alpha: 0.8),
                      item['gradient'][1].withValues(alpha: 0.9),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(item['image']),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withValues(alpha: 0.4),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth > 768 ? 48 : 32,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              item['subtitle'],
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: screenWidth > 768 ? 18 : 16,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Learn More',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Indicators
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _carouselItems.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentCarouselIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentCarouselIndex == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
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
              Text(
                'Browse by Category',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: _categories.map((category) {
                  final isSelected = category == _selectedCategory;
                  return GestureDetector(
                    onTap: () => _onCategoryChanged(category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.black.withValues(alpha: 0.2),
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.red.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [
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
    final paginatedArticles = _paginatedArticles;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest Articles',
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth < 600 ? 20 : 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          screenWidth > 768
              ? _buildGrid(paginatedArticles)
              : _buildList(paginatedArticles),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context) {
    if (_totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          if (_currentPage > 1)
            GestureDetector(
              onTap: () => _onPageChanged(_currentPage - 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios, size: 16, color: Colors.black.withValues(alpha: 0.7)),
                    const SizedBox(width: 4),
                    Text(
                      'Previous',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          // Page numbers
          ...List.generate(_totalPages, (index) {
            final pageNumber = index + 1;
            final isCurrentPage = pageNumber == _currentPage;
            
            return GestureDetector(
              onTap: () => _onPageChanged(pageNumber),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isCurrentPage ? Colors.red : Colors.transparent,
                  border: Border.all(
                    color: isCurrentPage ? Colors.red : Colors.grey.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  pageNumber.toString(),
                  style: TextStyle(
                    color: isCurrentPage ? Colors.white : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
          
          // Next button
          if (_currentPage < _totalPages)
            GestureDetector(
              onTap: () => _onPageChanged(_currentPage + 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black.withValues(alpha: 0.7)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<Map<String, dynamic>> articles) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) => _buildCard(articles[index]),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> articles) {
    return Column(
      children: articles
          .map((article) => Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: _buildCard(article, isMobile: true),
              ))
          .toList(),
    );
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
                  colors: [
                    Colors.red.withValues(alpha: 0.1),
                    Colors.red.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.lightbulb_outline,
                      size: isMobile ? 50 : 60,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        article['category'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                      Text(
                        article['title'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          article['subtitle'],
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.7),
                            fontSize: isMobile ? 12 : 14,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red.withValues(alpha: 0.1),
                            child: Text(
                              article['author'].substring(0, 1),
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article['author'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  article['readTime'],
                                  style: TextStyle(
                                    color: Colors.black.withValues(alpha: 0.6),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        article['date'],
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.5),
                          fontSize: 10,
                        ),
                      ),
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