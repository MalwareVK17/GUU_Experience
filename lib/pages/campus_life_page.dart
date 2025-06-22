import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CampusLifeItem {
  final String title;
  final String description;
  final String detailedDescription;
  final List<String> images; // Multiple images per card

  const CampusLifeItem({
    required this.title,
    required this.description,
    required this.detailedDescription,
    required this.images,
  });
}

class CampusLifePage extends StatefulWidget {
  const CampusLifePage({super.key});

  @override
  State<CampusLifePage> createState() => _CampusLifePageState();
}

class _CampusLifePageState extends State<CampusLifePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Track current image index for each card
  Map<int, int> cardImageIndexes = {};

  // Enhanced data with 8 detailed campus life items and multiple images
  final List<CampusLifeItem> campusLifeData = [
    const CampusLifeItem(
      title: 'Academic Excellence',
      description: 'World-class education and research facilities',
      detailedDescription:
          'Experience cutting-edge academic programs with state-of-the-art classrooms, advanced laboratories, and renowned faculty members dedicated to your success.',
      images: [
        'assets/image/ggut.jpeg',
        'assets/image/room.jpeg',
        'assets/image/semh.jpeg',
      ],
    ),
    const CampusLifeItem(
      title: 'Research Labs',
      description: 'Advanced research and innovation centers',
      detailedDescription:
          'Explore groundbreaking research opportunities in our modern laboratories equipped with cutting-edge technology and led by world-renowned researchers.',
      images: [
        'assets/image/lab.jpeg',
        'assets/image/lad2.jpg',
        'assets/image/mlab.png',
      ],
    ),
    const CampusLifeItem(
      title: 'Campus Events',
      description: 'Vibrant festivals and cultural celebrations',
      detailedDescription:
          'Join exciting cultural festivals, tech fests, annual celebrations, and seasonal events that bring the entire campus community together.',
      images: [
        'assets/image/sev.jpg',
        'assets/image/mev.jpg',
        'assets/image/evcm.png',
        'assets/image/Event2.png',
      ],
    ),
    const CampusLifeItem(
      title: 'Student Clubs',
      description: 'Diverse organizations for every passion',
      detailedDescription:
          'Explore 50+ student clubs including robotics, debate, drama, music, photography, and entrepreneurship clubs.',
      images: [
        'assets/image/vke.jpg',
        'assets/image/club.jpeg',
        'assets/image/stc.jpg',
      ],
    ),
    const CampusLifeItem(
      title: 'Sports',
      description: 'State-of-the-art athletic facilities',
      detailedDescription:
          'Modern gymnasium, swimming pool, tennis courts, football field, and fitness center with professional trainers.',
      images: [
        'assets/image/sport2.jpeg',
        'assets/image/spv.jpg',
        'assets/image/ground.png',
        'assets/image/se.png',
      ],
    ),
    const CampusLifeItem(
      title: 'Central Library',
      description: 'Digital and print resources hub',
      detailedDescription:
          'A 5-story modern library housing 200,000+ books, digital databases, study pods, and 24/7 reading spaces.',
      images: [
        'assets/image/geclib.jpg',
        'assets/image/ggulib.png',
        'assets/image/cl.jpg',
      ],
    ),
    const CampusLifeItem(
      title: 'Hostels',
      description: 'Comfortable residential experience',
      detailedDescription:
          'Modern dormitories with Wi-Fi, study areas, recreational facilities, and 24/7 security for a home-like experience.',
      images: [
        'assets/image/overall.png',
        'assets/image/hostal2.png',
        'assets/image/hostal3.png',
        'assets/image/hos.jpeg',
      ],
    ),
    const CampusLifeItem(
      title: 'Canteen',
      description: 'Variety of food options',
      detailedDescription:
          'A diverse range of cuisines, including vegetarian, non-vegetarian, and international dishes, with a focus on fresh, healthy, and affordable meals.',
      images: [
        'assets/image/canteen2.png',
        'assets/image/mes1.png',
        'assets/image/gc.jpg',
      ],
    ),
    const CampusLifeItem(
      title: 'Transportation',
      description: 'Convenient transportation options',
      detailedDescription:
          'Convenient transportation options for students, including bus services and bike rentals.',
      images: [
        'assets/image/bus.jpg',
        'assets/image/buggy.jpg',
        'assets/image/cycle2.jpg',
        'assets/image/bus2.jpg',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    // Initialize image indexes
    for (int i = 0; i < campusLifeData.length; i++) {
      cardImageIndexes[i] = 0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        title: const Text(
          'Campus Life',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 221, 220, 220),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 241, 205, 205),
                Color.fromARGB(255, 241, 205, 205),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeaderSection(),

              const SizedBox(height: 30),

              // Cards List - Vertical Scrolling
              ...campusLifeData.asMap().entries.map((entry) {
                int index = entry.key;
                CampusLifeItem item = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _buildVerticalCard(item, index),
                );
              }).toList(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 200, // Set a fixed height for the header
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage(
            'assets/image/life.jpg',
          ), // Replace with your header image
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.3),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Campus Life',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3.0,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Explore our vibrant campus facilities and opportunities',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3.0,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalCard(CampusLifeItem item, int cardIndex) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Carousel Section - Horizontal sliding
          Container(
            width: 356, // Specified width
            height: 273, // Specified height
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  // Image Carousel
                  CarouselSlider.builder(
                    itemCount: item.images.length,
                    options: CarouselOptions(
                      height: 273,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      autoPlayCurve: Curves.easeInOutCubic,
                      onPageChanged: (index, reason) {
                        setState(() {
                          cardImageIndexes[cardIndex] = index;
                        });
                      },
                    ),
                    itemBuilder: (context, imageIndex, realIndex) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(item.images[imageIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Image indicators
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: item.images.asMap().entries.map((entry) {
                          bool isActive =
                              (cardImageIndexes[cardIndex] ?? 0) == entry.key;
                          return Container(
                            width: isActive ? 8 : 6,
                            height: isActive ? 8 : 6,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: isActive ? Colors.white : Colors.white54,
                              shape: BoxShape.circle,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${campusLifeData.indexOf(item) + 1}/8',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 12),

                // Detailed Description
                Text(
                  item.detailedDescription,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
