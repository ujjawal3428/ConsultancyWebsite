import 'package:consultancy_website/custom_app_bar.dart';
import 'package:consultancy_website/widgets/footer_widget.dart';
import 'package:flutter/material.dart';


class Undergraduateprep extends StatelessWidget {
  const Undergraduateprep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(),
            HeroSection(),
            StagesSection(),
            BenefitsSection(),
            ConsultantsSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}


class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.red[700],
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Build a Competitive Undergraduate Profile',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Transform your academic journey with strategic guidance and mentorship',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            onPressed: () {},
            child: Text(
              'Get Started',
              style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StagesSection extends StatelessWidget {
  const StagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = [
      {
        'title': 'Explore',
        'description': 'Focus on exploring diverse academic & non-academic interests'
      },
      {
        'title': 'Identify',
        'description':
            'Identify 3-4 activities that are important to you & build a personal storyline'
      },
      {
        'title': 'Elevate',
        'description':
            'Elevate your application competitiveness by executing in-depth projects'
      },
      {
        'title': 'Curate',
        'description':
            'Curate your application towards your higher education goals'
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 80),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4 Stages of Building Your Profile',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 40,
              crossAxisSpacing: 40,
              childAspectRatio: 1.2,
            ),
            itemCount: stages.length,
            itemBuilder: (context, index) {
              return StageCard(
                number: index + 1,
                title: stages[index]['title']!,
                description: stages[index]['description']!,
              );
            },
          ),
        ],
      ),
    );
  }
}

class StageCard extends StatelessWidget {
  final int number;
  final String title;
  final String description;

  const StageCard({
    super.key,
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.red[700],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black54,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitsSection extends StatelessWidget {
  const BenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 80),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose Us',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            spacing: 40,
            children: [
              Expanded(
                child: BenefitItem(
                  icon: '✓',
                  title: 'Expert Mentors',
                  description:
                      'Learn from graduates of top universities worldwide',
                ),
              ),
              Expanded(
                child: BenefitItem(
                  icon: '✓',
                  title: 'Personalized Strategy',
                  description:
                      'Tailored guidance aligned with your goals and interests',
                ),
              ),
              Expanded(
                child: BenefitItem(
                  icon: '✓',
                  title: 'Proven Results',
                  description:
                      'Track record of successful applications to top institutions',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BenefitItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const BenefitItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          icon,
          style: TextStyle(
            color: Colors.red[700],
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white70,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class ConsultantsSection extends StatelessWidget {
  const ConsultantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 80),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Team',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Global team of consultants holding degrees from prestigious universities',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            spacing: 32,
            children: [
              Expanded(child: ConsultantCard(name: 'Sarah Johnson')),
              Expanded(child: ConsultantCard(name: 'Michael Chen')),
              Expanded(child: ConsultantCard(name: 'Emma Williams')),
            ],
          ),
        ],
      ),
    );
  }
}

class ConsultantCard extends StatelessWidget {
  final String name;

  const ConsultantCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Consultant',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
