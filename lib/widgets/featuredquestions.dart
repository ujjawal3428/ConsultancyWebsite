import 'package:consultancy_website/models/college.dart';
import 'package:flutter/material.dart';

class FeaturedQuestion {
  final String question;
  final String answer;
  final IconData icon;

  FeaturedQuestion({
    required this.question,
    required this.answer,
    required this.icon,
  });
}

class FeaturedQuestionsWidget extends StatefulWidget {
  final College college;

  const FeaturedQuestionsWidget({super.key, required this.college});

  @override
  State<FeaturedQuestionsWidget> createState() => _FeaturedQuestionsWidgetState();
}

class _FeaturedQuestionsWidgetState extends State<FeaturedQuestionsWidget> {
  final Set<int> expandedQuestions = {};

  // Get questions based on college degree/type
  List<FeaturedQuestion> _getQuestionsForCollege() {
    final type = widget.college.type.toLowerCase();
    
    // MBBS/Medical
    if (type.contains('mbbs') || type.contains('medical') || type.contains('medicine')) {
      return [
        FeaturedQuestion(
          question: 'High Success Rate in Medical Licensing Exams',
          answer: 'Our students consistently achieve excellent results in NEET-PG, USMLE, and PLAB exams with comprehensive coaching and support throughout their medical education journey.',
          icon: Icons.medical_services,
        ),
        FeaturedQuestion(
          question: 'World-Class Clinical Training Facilities',
          answer: 'Access to state-of-the-art hospitals with over 1000+ beds, advanced simulation labs, and hands-on clinical experience from the first year of study.',
          icon: Icons.local_hospital,
        ),
        FeaturedQuestion(
          question: 'International Recognition and Accreditation',
          answer: 'Degrees recognized by WHO, NMC, and international medical councils, enabling practice opportunities worldwide with strong alumni network in top hospitals globally.',
          icon: Icons.verified,
        ),
        FeaturedQuestion(
          question: 'Expert Faculty with Clinical Experience',
          answer: 'Learn from renowned doctors and professors with extensive clinical practice, research publications, and dedication to producing competent healthcare professionals.',
          icon: Icons.school,
        ),
        FeaturedQuestion(
          question: 'Strong Placement Support in Healthcare',
          answer: 'Guaranteed internship placements in premier hospitals, residency guidance, and career counseling to help you secure positions in leading healthcare institutions.',
          icon: Icons.work,
        ),
      ];
    }
    
    // Engineering
    if (type.contains('engineering') || type.contains('b.tech') || type.contains('btech')) {
      return [
        FeaturedQuestion(
          question: 'Industry-Aligned Curriculum with Latest Technologies',
          answer: 'Updated curriculum covering AI, Machine Learning, IoT, Cloud Computing, and emerging technologies with regular industry expert sessions and workshops.',
          icon: Icons.memory,
        ),
        FeaturedQuestion(
          question: 'Excellent Placement Record with Top Companies',
          answer: 'Average package of 8+ LPA with top recruiters including Google, Microsoft, Amazon, TCS, Infosys, and 300+ companies visiting campus annually.',
          icon: Icons.trending_up,
        ),
        FeaturedQuestion(
          question: 'Modern Labs and Research Facilities',
          answer: 'Access to cutting-edge laboratories, innovation centers, fabrication labs, and research facilities with industry-standard equipment and software.',
          icon: Icons.science,
        ),
        FeaturedQuestion(
          question: 'Strong Industry Partnerships and Internships',
          answer: 'Collaborations with leading tech companies providing guaranteed internship opportunities, live projects, and real-world problem-solving experience.',
          icon: Icons.handshake,
        ),
        FeaturedQuestion(
          question: 'Experienced Faculty and Mentorship Programs',
          answer: 'Learn from IIT/NIT alumni and industry professionals with personalized mentorship, career guidance, and support for higher studies abroad.',
          icon: Icons.person,
        ),
      ];
    }
    
    // MCA
    if (type.contains('mca') || type.contains('computer applications')) {
      return [
        FeaturedQuestion(
          question: 'Advanced Programming and Software Development',
          answer: 'Comprehensive training in full-stack development, cloud technologies, mobile app development, and software engineering with industry-relevant projects.',
          icon: Icons.code,
        ),
        FeaturedQuestion(
          question: 'Strong IT Placement Support',
          answer: 'Dedicated placement cell with 95% placement rate, connections with top IT companies, and salary packages ranging from 6-15 LPA for skilled candidates.',
          icon: Icons.computer,
        ),
        FeaturedQuestion(
          question: 'Specialization in Emerging Technologies',
          answer: 'Electives in Data Science, Cybersecurity, Blockchain, Artificial Intelligence, and Cloud Computing to stay ahead in the competitive tech landscape.',
          icon: Icons.auto_awesome,
        ),
        FeaturedQuestion(
          question: 'Industry Certifications and Training',
          answer: 'Free certifications from AWS, Google, Microsoft, and Oracle included in the program with regular hackathons and coding competitions.',
          icon: Icons.workspace_premium,
        ),
        FeaturedQuestion(
          question: 'Research Opportunities and Innovation',
          answer: 'Encouragement for research publications, participation in tech conferences, and funding support for innovative project ideas.',
          icon: Icons.lightbulb,
        ),
      ];
    }
    
    // BCA
    if (type.contains('bca') || type.contains('bachelor') && type.contains('computer')) {
      return [
        FeaturedQuestion(
          question: 'Strong Foundation in Computer Science',
          answer: 'Comprehensive coverage of programming fundamentals, data structures, algorithms, and core computer science concepts with practical implementation.',
          icon: Icons.laptop,
        ),
        FeaturedQuestion(
          question: 'Practical Skills with Industry Tools',
          answer: 'Hands-on training with popular frameworks, development tools, version control systems, and exposure to real-world software development practices.',
          icon: Icons.construction,
        ),
        FeaturedQuestion(
          question: 'Career Guidance for IT Industry',
          answer: 'Placement assistance with IT companies, startups, and MNCs with average packages of 4-8 LPA, plus guidance for higher studies like MCA.',
          icon: Icons.route,
        ),
        FeaturedQuestion(
          question: 'Project-Based Learning Approach',
          answer: 'Major and minor projects in each semester, industry internships, and capstone projects that build your portfolio for job applications.',
          icon: Icons.folder_special,
        ),
        FeaturedQuestion(
          question: 'Affordable Quality Education',
          answer: 'Cost-effective program with excellent ROI, scholarship opportunities for meritorious students, and flexible payment options available.',
          icon: Icons.savings,
        ),
      ];
    }
    
    // MBA/Management
    if (type.contains('mba') || type.contains('management') || type.contains('business')) {
      return [
        FeaturedQuestion(
          question: 'Comprehensive Business Management Training',
          answer: 'Holistic approach covering finance, marketing, HR, operations, and strategy with case study methodology and business simulation exercises.',
          icon: Icons.business_center,
        ),
        FeaturedQuestion(
          question: 'Strong Corporate Connections',
          answer: 'Regular CEO talks, corporate visits, live business projects, and networking opportunities with industry leaders and successful alumni.',
          icon: Icons.groups,
        ),
        FeaturedQuestion(
          question: 'Excellent Placement in Top Companies',
          answer: 'Average package of 10+ LPA with placements in consulting firms, MNCs, banks, and Fortune 500 companies across various domains.',
          icon: Icons.star,
        ),
        FeaturedQuestion(
          question: 'Entrepreneurship Development Support',
          answer: 'Incubation center, seed funding opportunities, mentorship from successful entrepreneurs, and resources to launch your own venture.',
          icon: Icons.rocket_launch,
        ),
        FeaturedQuestion(
          question: 'Global Exposure and Exchange Programs',
          answer: 'International study tours, student exchange programs with partner universities, and global immersion programs to broaden perspectives.',
          icon: Icons.flight,
        ),
      ];
    }
    
    // Default questions for other programs
    return [
      FeaturedQuestion(
        question: 'Quality Education with Experienced Faculty',
        answer: 'Learn from qualified professors with years of teaching experience and industry exposure, dedicated to student success and academic excellence.',
        icon: Icons.school,
      ),
      FeaturedQuestion(
        question: 'Modern Infrastructure and Facilities',
        answer: 'Well-equipped classrooms, digital libraries, laboratories, sports facilities, and comfortable hostel accommodations for holistic development.',
        icon: Icons.apartment,
      ),
      FeaturedQuestion(
        question: 'Strong Academic Track Record',
        answer: 'Consistent university rankings, high pass percentages, and academic achievements by students in various competitive examinations.',
        icon: Icons.emoji_events,
      ),
      FeaturedQuestion(
        question: 'Comprehensive Career Support',
        answer: 'Dedicated training and placement cell providing career counseling, skill development programs, and placement assistance with leading organizations.',
        icon: Icons.support_agent,
      ),
      FeaturedQuestion(
        question: 'Holistic Development Programs',
        answer: 'Focus on overall personality development through extracurricular activities, seminars, workshops, cultural events, and leadership programs.',
        icon: Icons.diversity_3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final questions = _getQuestionsForCollege();
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 0 : 0,
            vertical: isMobile ? 20 : 28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(isMobile),
              SizedBox(height: isMobile ? 20 : 24),
              _buildQuestionsList(questions, isMobile),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.recommend,
                size: 22,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Why Choose ${widget.college.type}',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Key reasons why students and parents prefer this program',
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionsList(List<FeaturedQuestion> questions, bool isMobile) {
    return Column(
      children: List.generate(questions.length, (index) {
        final question = questions[index];
        final isExpanded = expandedQuestions.contains(index);
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isExpanded ? Colors.red.shade200 : Colors.grey.shade200,
              width: isExpanded ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isExpanded) {
                    expandedQuestions.remove(index);
                  } else {
                    expandedQuestions.add(index);
                  }
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 14 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            question.icon,
                            size: 18,
                            color: Colors.red.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              question.question,
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade900,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isExpanded ? Colors.red.shade50 : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            isExpanded ? Icons.remove : Icons.add,
                            size: 16,
                            color: isExpanded ? Colors.red.shade600 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    if (isExpanded) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(isMobile ? 12 : 14),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                              color: Colors.red.shade400,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          question.answer,
                          style: TextStyle(
                            fontSize: isMobile ? 12.5 : 13.5,
                            color: Colors.grey.shade700,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}