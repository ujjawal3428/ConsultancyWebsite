import 'package:consultancy_website/custom_app_bar.dart';
import 'package:consultancy_website/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Newsroom extends StatefulWidget {
  const Newsroom({super.key});

  @override
  State<Newsroom> createState() => _NewsroomState();
}

class _NewsroomState extends State<Newsroom> {
  String _selectedCategory = 'All';
  int _currentPage = 1;
  static const int _articlesPerPage = 6;
  
  late PageController _carouselController;
  late Timer _carouselTimer;
  int _currentCarouselIndex = 0;

  static const List<String> _categories = [
    'All', 'Technology', 'Business', 'Innovation', 'Strategy'
  ];
  
  static const List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'Digital Transformation Summit 2025',
      'subtitle': 'Join industry leaders in exploring the future of digital innovation',
      'image': 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1920&q=80',
      'colors': [Color(0xFF2196F3), Color(0xFF9C27B0)],
    },
    {
      'title': 'AI-Powered Business Solutions',
      'subtitle': 'Discover how artificial intelligence is revolutionizing modern enterprises',
      'image': 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=1920&q=80',
      'colors': [Color(0xFFFF5722), Color(0xFFFF9800)],
    },
    {
      'title': 'Sustainable Innovation Conference',
      'subtitle': 'Building tomorrow\'s solutions with environmental responsibility',
      'image': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1920&q=80',
      'colors': [Color(0xFF4CAF50), Color(0xFF009688)],
    },
  ];
  
  static const List<Map<String, dynamic>> _articles = [
    {
      'title': 'AI Revolution in Enterprise Solutions',
      'subtitle': 'How artificial intelligence is transforming business operations across industries',
      'category': 'Technology',
      'date': 'Sep 18, 2025',
      'readTime': '8 min',
      'author': 'Sarah Chen',
    },
    {
      'title': 'Sustainable Business Practices',
      'subtitle': 'Building eco-friendly strategies for long-term growth and environmental responsibility',
      'category': 'Business',
      'date': 'Sep 15, 2025',
      'readTime': '6 min',
      'author': 'Michael Rodriguez',
    },
    {
      'title': 'The Future of Remote Collaboration',
      'subtitle': 'Innovative tools and methodologies reshaping how teams work together',
      'category': 'Innovation',
      'date': 'Sep 12, 2025',
      'readTime': '5 min',
      'author': 'Emma Thompson',
    },
    {
      'title': 'Data-Driven Decision Making',
      'subtitle': 'Leveraging analytics and insights to drive strategic business outcomes',
      'category': 'Strategy',
      'date': 'Sep 10, 2025',
      'readTime': '7 min',
      'author': 'David Kim',
    },
    {
      'title': 'Cybersecurity in Digital Age',
      'subtitle': 'Protecting your business from evolving threats in the digital landscape',
      'category': 'Technology',
      'date': 'Sep 8, 2025',
      'readTime': '9 min',
      'author': 'Lisa Park',
    },
    {
      'title': 'Blockchain Beyond Cryptocurrency',
      'subtitle': 'Exploring practical applications of blockchain technology in business',
      'category': 'Innovation',
      'date': 'Sep 5, 2025',
      'readTime': '6 min',
      'author': 'James Wilson',
    },
    {
      'title': 'Cloud Computing Strategies',
      'subtitle': 'Optimizing cloud infrastructure for scalable business growth',
      'category': 'Technology',
      'date': 'Sep 3, 2025',
      'readTime': '7 min',
      'author': 'Anna Martinez',
    },
    {
      'title': 'Digital Marketing Evolution',
      'subtitle': 'Leveraging new technologies for effective customer engagement',
      'category': 'Business',
      'date': 'Sep 1, 2025',
      'readTime': '5 min',
      'author': 'Robert Taylor',
    },
    {
      'title': 'IoT in Manufacturing',
      'subtitle': 'Internet of Things revolutionizing industrial processes and efficiency',
      'category': 'Innovation',
      'date': 'Aug 29, 2025',
      'readTime': '8 min',
      'author': 'Kevin Zhang',
    },
    {
      'title': 'Agile Leadership Principles',
      'subtitle': 'Leading teams effectively in rapidly changing business environments',
      'category': 'Strategy',
      'date': 'Aug 27, 2025',
      'readTime': '6 min',
      'author': 'Sophie Brown',
    },
  ];

  List<Map<String, dynamic>> get _filteredArticles => _selectedCategory == 'All'
      ? _articles
      : _articles.where((article) => article['category'] == _selectedCategory).toList();

  List<Map<String, dynamic>> get _paginatedArticles {
    final filtered = _filteredArticles;
    final start = (_currentPage - 1) * _articlesPerPage;
    final end = (start + _articlesPerPage).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  int get _totalPages => (_filteredArticles.length / _articlesPerPage).ceil();

  @override
  void initState() {
    super.initState();
    _carouselController = PageController();
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
      if (!_carouselController.hasClients) return;
      
      final nextIndex = (_currentCarouselIndex + 1) % _carouselItems.length;
      _carouselController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
      _currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _CarouselBanner(
              controller: _carouselController,
              items: _carouselItems,
              currentIndex: _currentCarouselIndex,
              onPageChanged: (index) => setState(() => _currentCarouselIndex = index),
            ),
            _CategoryFilter(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategoryChanged: _onCategoryChanged,
            ),
            _ArticlesSection(articles: _paginatedArticles),
            _Pagination(
              currentPage: _currentPage,
              totalPages: _totalPages,
              onPageChanged: (page) => setState(() => _currentPage = page),
            ),
            const SizedBox(height: 60),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _CarouselBanner extends StatelessWidget {
  final PageController controller;
  final List<Map<String, dynamic>> items;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const _CarouselBanner({
    required this.controller,
    required this.items,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxWidth > 768 ? 400.0 : 300.0;
        
        return SizedBox(
          height: height,
          child: Stack(
            children: [
              PageView.builder(
                controller: controller,
                onPageChanged: onPageChanged,
                itemCount: items.length,
                itemBuilder: (context, index) => _CarouselItem(
                  item: items[index],
                  isDesktop: constraints.maxWidth > 768,
                ),
              ),
              _CarouselIndicators(
                itemCount: items.length,
                currentIndex: currentIndex,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CarouselItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isDesktop;

  const _CarouselItem({
    required this.item,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: (item['colors'] as List<Color>)
              .map((c) => c.withValues(alpha : 0.85))
              .toList(),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              item['image'],
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha : 0.4),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isDesktop ? 48 : 32,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item['subtitle'],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha : 0.9),
                        fontSize: isDesktop ? 18 : 16,
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Learn More',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
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
}

class _CarouselIndicators extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const _CarouselIndicators({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemCount,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentIndex == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? Colors.white
                  : Colors.white.withValues(alpha : 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const _CategoryFilter({
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Browse by Category',
                style: TextStyle(
                  color: Colors.black.withValues(alpha : 0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: categories.map((category) => _CategoryChip(
                  label: category,
                  isSelected: category == selectedCategory,
                  onTap: () => onCategoryChanged(category),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey.withValues(alpha : 0.3),
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? Colors.red.withValues(alpha : 0.2)
                  : Colors.grey.withValues(alpha : 0.1),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black.withValues(alpha : 0.8),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ArticlesSection extends StatelessWidget {
  final List<Map<String, dynamic>> articles;

  const _ArticlesSection({required this.articles});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 768;
        final isTablet = constraints.maxWidth > 600;
        
        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latest Articles',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isDesktop ? 28 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
                  childAspectRatio: isDesktop ? 0.85 : (isTablet ? 0.9 : 1.2),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: articles.length,
                itemBuilder: (context, index) => _ArticleCard(
                  article: articles[index],
                  isCompact: !isDesktop,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Map<String, dynamic> article;
  final bool isCompact;

  const _ArticleCard({
    required this.article,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ArticleImage(
            category: article['category'],
            height: isCompact ? 140 : 180,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'],
                    style: TextStyle(
                      fontSize: isCompact ? 16 : 18,
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
                        color: Colors.grey[600],
                        fontSize: isCompact ? 12 : 14,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ArticleMetadata(
                    author: article['author'],
                    readTime: article['readTime'],
                    date: article['date'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleImage extends StatelessWidget {
  final String category;
  final double height;

  const _ArticleImage({
    required this.category,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        gradient: LinearGradient(
          colors: [
            Colors.red.withValues(alpha : 0.1),
            Colors.red.withValues(alpha : 0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.lightbulb_outline, size: 60, color: Colors.red),
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
                category,
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
    );
  }
}

class _ArticleMetadata extends StatelessWidget {
  final String author;
  final String readTime;
  final String date;

  const _ArticleMetadata({
    required this.author,
    required this.readTime,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red.withValues(alpha : 0.1),
              child: Text(
                author[0],
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
                    author,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    readTime,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          date,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const _Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          if (currentPage > 1)
            _PaginationButton(
              onTap: () => onPageChanged(currentPage - 1),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chevron_left, size: 16),
                  Text('Previous'),
                ],
              ),
            ),
          
          ...List.generate(totalPages, (index) {
            final pageNumber = index + 1;
            return _PaginationButton(
              onTap: () => onPageChanged(pageNumber),
              isActive: pageNumber == currentPage,
              child: Text(pageNumber.toString()),
            );
          }),
          
          if (currentPage < totalPages)
            _PaginationButton(
              onTap: () => onPageChanged(currentPage + 1),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Next'),
                  Icon(Icons.chevron_right, size: 16),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final bool isActive;

  const _PaginationButton({
    required this.onTap,
    required this.child,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.transparent,
          border: Border.all(
            color: isActive ? Colors.red : Colors.grey.withValues(alpha : 0.3),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: isActive ? Colors.white : Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          child: child,
        ),
      ),
    );
  }
}