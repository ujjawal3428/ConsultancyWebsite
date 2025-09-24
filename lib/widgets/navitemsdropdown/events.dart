import 'package:consultancy_website/widgets/custom_app_bar.dart';
import 'package:consultancy_website/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverToBoxAdapter(
            child: CustomAppBar(),
          ),
          
          // Tab Bar
          SliverToBoxAdapter(
            child: _buildTabBar(),
          ),
          
          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEventsGrid(_getAllEvents()),
                _buildEventsGrid(_getPastEvents()),
                _buildEventsGrid(_getUpcomingEvents()),
              ],
            ),
          ),
          
          // Footer
          SliverToBoxAdapter(
            child: FooterSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(25),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF6B7280),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          tabs: const [
            Tab(text: 'All Events'),
            Tab(text: 'Past'),
            Tab(text: 'Upcoming'),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsGrid(List<EventModel> events) {
    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No events found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800 ? 3 : 
                            constraints.maxWidth > 500 ? 2 : 1;
        
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling since we're using CustomScrollView
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) => _buildEventCard(events[index]),
          ),
        );
      },
    );
  }

  Widget _buildEventCard(EventModel event) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showEventDetails(event),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  image: DecorationImage(
                    image: NetworkImage(event.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Status badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: event.isPast ? Colors.grey : Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          event.isPast ? 'PAST' : 'UPCOMING',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // Date badge
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              event.day,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              event.month,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Event Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red, size: 12),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6B7280),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.red, size: 12),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.time,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6B7280),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 28,
                      child: ElevatedButton(
                        onPressed: event.isPast ? null : () => _showEventDetails(event),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: event.isPast ? const Color(0xFFF3F4F6) : Colors.red,
                          foregroundColor: event.isPast ? const Color(0xFF6B7280) : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          event.isPast ? 'COMPLETED' : 'VIEW DETAILS',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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

  void _showEventDetails(EventModel event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildEventDetailsModal(event),
    );
  }

  Widget _buildEventDetailsModal(EventModel event) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Image
                  Container(
                    height: 200,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(event.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.location_on, color: Colors.red, size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      event.location,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF1A1A1A),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, color: Colors.red, size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      event.dateTime,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF1A1A1A),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        const Text(
                          'About Event',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          event.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            height: 1.5,
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
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'REGISTER NOW',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<EventModel> _getAllEvents() {
    return [..._getUpcomingEvents(), ..._getPastEvents()];
  }

  List<EventModel> _getUpcomingEvents() {
    return [
      EventModel(
        title: 'Tech Innovation Summit',
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
        description: 'A stunning collection of contemporary artworks by emerging and established artists, celebrating the beauty of autumn through various mediums.',
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
        description: 'An exclusive networking event connecting entrepreneurs, professionals, and industry experts in a sophisticated rooftop setting.',
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