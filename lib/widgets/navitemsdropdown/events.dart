import 'package:consultancy_website/custom_app_bar.dart';
import 'package:consultancy_website/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All Events', 'Upcoming', 'Past Events'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CustomAppBar()),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildCategoryTabs(),
                _buildEventsContent(),
              ],
            ),
          ),
          SliverToBoxAdapter(child: FooterSection()),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_categories.length, (index) {
          bool isSelected = _selectedCategoryIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedCategoryIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _categories[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEventsContent() {
    List<EventModel> events = _getEventsForCategory(_selectedCategoryIndex);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text(
              '${events.length} ${events.length == 1 ? 'event' : 'events'} found',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildEventsGrid(events),
        ],
      ),
    );
  }

  List<EventModel> _getEventsForCategory(int categoryIndex) {
    switch (categoryIndex) {
      case 0:
        return [..._getUpcomingEvents(), ..._getPastEvents()];
      case 1:
        return _getUpcomingEvents();
      case 2:
        return _getPastEvents();
      default:
        return [];
    }
  }

  Widget _buildEventsGrid(List<EventModel> events) {
    if (events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            children: [
              Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No events found',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = constraints.maxWidth > 900 ? 3 : constraints.maxWidth > 600 ? 2 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: events.length,
          itemBuilder: (context, index) => _buildEventCard(events[index]),
        );
      },
    );
  }

  Widget _buildEventCard(EventModel event) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showEventDetails(event),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      image: DecorationImage(
                        image: NetworkImage(event.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: event.isPast ? Colors.grey : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        event.isPast ? 'PAST' : 'UPCOMING',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            event.day,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            event.month,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.red, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.time,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDetails(EventModel event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 240,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(event.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(Icons.location_on, event.location),
                          const SizedBox(height: 12),
                          _buildInfoRow(Icons.access_time, event.dateTime),
                          const SizedBox(height: 20),
                          const Text(
                            'About Event',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            event.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (!event.isPast)
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Registration for ${event.title} initiated!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'REGISTER NOW',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.red, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  List<EventModel> _getUpcomingEvents() {
    return [
      EventModel(
        title: 'Tech Innovation Summit 2024',
        location: 'Convention Center, Downtown',
        dateTime: 'Dec 15, 2024 - 9:00 AM',
        time: '9:00 AM - 6:00 PM',
        day: '15',
        month: 'DEC',
        description: 'Join industry leaders and innovators for a day of inspiring talks, networking, and showcasing the latest technological breakthroughs.',
        isPast: false,
        imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800&h=600&fit=crop',
      ),
      EventModel(
        title: 'Winter Music Festival',
        location: 'City Park Amphitheater',
        dateTime: 'Dec 22, 2024 - 6:00 PM',
        time: '6:00 PM - 11:00 PM',
        day: '22',
        month: 'DEC',
        description: 'A magical evening of live music performances featuring local and international artists in a winter wonderland setting.',
        isPast: false,
        imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop',
      ),
    ];
  }

  List<EventModel> _getPastEvents() {
    return [
      EventModel(
        title: 'Autumn Art Exhibition',
        location: 'Gallery Downtown',
        dateTime: 'Oct 15, 2024 - 2:00 PM',
        time: '2:00 PM - 8:00 PM',
        day: '15',
        month: 'OCT',
        description: 'A stunning collection of contemporary artworks by emerging and established artists, celebrating the beauty of autumn.',
        isPast: true,
        imageUrl: 'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=800&h=600&fit=crop',
      ),
      EventModel(
        title: 'Business Networking Mixer',
        location: 'Rooftop Lounge, Sky Tower',
        dateTime: 'Nov 8, 2024 - 7:00 PM',
        time: '7:00 PM - 10:00 PM',
        day: '08',
        month: 'NOV',
        description: 'An exclusive networking event connecting entrepreneurs, professionals, and industry experts in a sophisticated setting.',
        isPast: true,
        imageUrl: 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=800&h=600&fit=crop',
      ),
    ];
  }
}

class EventModel {
  final String title;
  final String location;
  final String dateTime;
  final String time;
  final String day;
  final String month;
  final String description;
  final bool isPast;
  final String imageUrl;

  EventModel({
    required this.title,
    required this.location,
    required this.dateTime,
    required this.time,
    required this.day,
    required this.month,
    required this.description,
    required this.isPast,
    required this.imageUrl,
  });
}