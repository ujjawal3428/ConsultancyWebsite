import 'package:flutter/material.dart';

class BlogPost {
  final String title;
  final String category;
  final String date;
  final String imageUrl;
  final List<String> tags;

  BlogPost({
    required this.title,
    required this.category,
    required this.date,
    required this.imageUrl,
    required this.tags,
  });
}

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  // Sample blog data - replace with your actual data
  static final List<BlogPost> _blogPosts = [
    BlogPost(
      title: "UK Immigration Policy Changes for Students: What You Need to Know in 2025",
      category: "Postgraduate, Undergraduate",
      date: "September 10, 2025",
      imageUrl: "assets/images/blog1.jpg", // Replace with your image paths
      tags: ["Postgraduate", "Undergraduate"],
    ),
    BlogPost(
      title: "The Ultimate Master's Strategy: Connecting with Faculty",
      category: "Postgraduate",
      date: "August 29, 2025",
      imageUrl: "assets/images/blog2.jpg",
      tags: ["Postgraduate"],
    ),
    BlogPost(
      title: "How UK Boarding Schools like St Clare's, Oxford Develop Leadership Qualities",
      category: "Boarding School, Special Features",
      date: "July 4, 2025",
      imageUrl: "assets/images/blog3.jpg",
      tags: ["Boarding School", "Special Features"],
    ),
    BlogPost(
      title: "Top 10 Universities for International Students in 2025",
      category: "Undergraduate, Rankings",
      date: "June 15, 2025",
      imageUrl: "assets/images/blog4.jpg",
      tags: ["Undergraduate", "Rankings"],
    ),
    BlogPost(
      title: "Scholarship Opportunities: A Complete Guide for Global Students",
      category: "Scholarships, Finance",
      date: "May 22, 2025",
      imageUrl: "assets/images/blog5.jpg",
      tags: ["Scholarships", "Finance"],
    ),
    BlogPost(
      title: "Preparing for IELTS: Essential Tips for Success",
      category: "Test Preparation",
      date: "April 18, 2025",
      imageUrl: "assets/images/blog6.jpg",
      tags: ["Test Preparation"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          // Section Header
          const Text(
            'Our Blog',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Keep up on the latest trends in global education, admissions and more',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF7F8C8D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          
          // Responsive Blog Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double childAspectRatio;
              
              if (constraints.maxWidth >= 1200) {
                // Desktop: 3 columns
                crossAxisCount = 3;
                childAspectRatio = 0.75;
              } else if (constraints.maxWidth >= 768) {
                // Tablet/iPad: 2 columns
                crossAxisCount = 2;
                childAspectRatio = 0.8;
              } else {
                // Mobile: 1 column
                crossAxisCount = 1;
                childAspectRatio = 1.2;
              }
              
              return Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 54,
                    mainAxisSpacing: 54,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: _blogPosts.length,
                  itemBuilder: (context, index) {
                    return BlogCard(blogPost: _blogPosts[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BlogCard extends StatefulWidget {
  final BlogPost blogPost;

  const BlogCard({super.key, required this.blogPost});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered 
                        ? Colors.black.withValues(alpha : 0.15)
                        : Colors.black.withValues(alpha : 0.08),
                    blurRadius: _isHovered ? 20 : 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blog Image
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        image: DecorationImage(
                          // Use AssetImage for local images or NetworkImage for web images
                          image: AssetImage(widget.blogPost.imageUrl),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                            // Fallback for missing images
                          },
                        ),
                      ),
                      child: widget.blogPost.imageUrl.isEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                  
                  // Blog Content
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tags
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: widget.blogPost.tags.map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE74C3C).withValues(alpha : 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  tag,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFE74C3C),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Blog Title
                          Expanded(
                            child: Text(
                              widget.blogPost.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E50),
                                height: 1.3,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Date and Read More
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.blogPost.date,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF7F8C8D),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Handle blog navigation
                                  print('Navigate to: ${widget.blogPost.title}');
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFFE74C3C),
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Read More',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
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
            ),
          );
        },
      ),
    );
  }
  }