import 'package:consultancy_website/custom_app_bar.dart';
import 'package:consultancy_website/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class Newsroom extends StatefulWidget {
  const Newsroom({super.key});

  @override
  State<Newsroom> createState() => _NewsroomState();
}

class _NewsroomState extends State<Newsroom> {
  String _selectedCategory = 'All';

  static const List<String> _categories = [
    'All', 'Technology', 'Business', 'Innovation', 'Strategy'
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
  ];

  List<Map<String, dynamic>> get _filteredArticles => _selectedCategory == 'All'
      ? _articles
      : _articles.where((article) => article['category'] == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            
            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade700, Colors.red.shade900],
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: [
                      const Text(
                        'Newsroom',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Stay updated with the latest insights and innovations',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha : 0.9),
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Category Filter
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              color: Colors.white,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: _categories.map((category) {
                      final isSelected = category == _selectedCategory;
                      return InkWell(
                        onTap: () => setState(() => _selectedCategory = category),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.red : Colors.white,
                            border: Border.all(
                              color: isSelected ? Colors.red : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            
            // Articles Grid
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.all(20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 1;
                  if (constraints.maxWidth > 900) {
                    crossAxisCount = 3;
                  } else if (constraints.maxWidth > 600) {
                    crossAxisCount = 2;
                  }
                  
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: _filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = _filteredArticles[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Article Image
                            Container(
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  const Center(
                                    child: Icon(
                                      Icons.article_outlined,
                                      size: 60,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
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
                            
                            // Article Content
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article['title'],
                                      style: const TextStyle(
                                        fontSize: 18,
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
                                          fontSize: 14,
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
                                          radius: 16,
                                          backgroundColor: Colors.red.shade50,
                                          child: Text(
                                            article['author'][0],
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
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
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                '${article['readTime']} • ${article['date']}',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            
            const SizedBox(height: 60),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}