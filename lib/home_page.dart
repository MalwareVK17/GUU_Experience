import 'package:flutter/material.dart';
import 'package:gguexpo/campus/gd_page.dart';
import 'package:gguexpo/campus/gec_page.dart';
import 'package:gguexpo/campus/ggu1_page.dart';
import 'package:gguexpo/campus/mca_page.dart';
import 'package:gguexpo/campus/gsp_page.dart';
import 'package:gguexpo/campus/rk_page.dart';
import 'package:gguexpo/campus/gpc_page.dart';
import 'package:gguexpo/foreignc/gv_page.dart';
import 'package:gguexpo/foreignc/rtg_page.dart';
import 'package:gguexpo/foreignc/sfu_page.dart';
import 'package:gguexpo/foreignc/uc_page.dart';
import 'package:gguexpo/pages/accreditations_page.dart';
import 'package:gguexpo/pages/admissions_page.dart';
import 'package:gguexpo/pages/campus_life_page.dart';
import 'package:gguexpo/pages/menu_page.dart';
import 'package:gguexpo/pages/placements_page.dart';
import 'package:gguexpo/pages/feedback_page.dart';
import 'package:video_player/video_player.dart';
import 'package:marquee/marquee.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  // Carousel state
  final PageController _carouselController = PageController(
    viewportFraction: 0.6,
  );
  int _currentCarouselIndex = 0;
  Timer? _carouselTimer;

  // Campus cards data
  final List<Map<String, dynamic>> _campusCards = [
    {
      'title': 'Godavri Global University',
      'image': 'assets/image/ggu.jpeg',
      'page': const Ggu1Page(),
    },
    {
      'title': 'MCA Block',
      'image': 'assets/image/mca.png',
      'page': const McaPage(),
    },
    {
      'title': 'Giet School Of Pharmacy',
      'image': 'assets/image/ps1.png',
      'page': const GspPage(),
    },
    {
      'title': 'RK Block',
      'image': 'assets/image/rk.png',
      'page': const RKPage(),
    },
    {
      'title': 'Giet Polytechnic College',
      'image': 'assets/image/del.png',
      'page': const GpcPage(),
    },
    {
      'title': 'Giet Engineering College',
      'image': 'assets/image/gec.jpg',
      'page': const GecPage(),
    },
    {
      'title': 'Giet Degree College',
      'image': 'assets/image/gd.webp',
      'page': const GDPage(),
    },
  ];

  // Foreign Collaboration cards data
  final List<Map<String, dynamic>> _foreignCollabCards = [
    {
      'title': 'Staffordshire University',
      'image': 'assets/image/fc2.png', // Replace with actual image path
      'page': const SFUPage(), // Replace with actual page
    },
    {
      'title': 'German Varsity',
      'image': 'assets/image/fc4.png', // Replace with actual image path
      'page': const GVPage(), // Replace with actual page
    },
    {
      'title': 'RWTH Aachen University',
      'image': 'assets/image/fc1.png', // Replace with actual image path
      'page': const RTGPage(), // Replace with actual page
    },
    {
      'title': 'University of California',
      'image': 'assets/image/fc3.png', // Replace with actual image path
      'page': const UCPage(), // Replace with actual page
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _startCarouselTimer();
  }

  void _startCarouselTimer() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentCarouselIndex < _campusCards.length - 1) {
        _currentCarouselIndex++;
      } else {
        _currentCarouselIndex = 0;
      }
      if (_carouselController.hasClients) {
        _carouselController.animateToPage(
          _currentCarouselIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentCarouselIndex = index;
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset('assets/video/gguw.mp4');
      await _controller.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _controller.play();
        _controller.setLooping(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  Widget _buildCampusCard(Map<String, dynamic> card) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => card['page'] as Widget),
        );
      },
      child: Container(
        width: 195,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image with error builder
              Image.asset(
                card['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  ),
                ),
              ),
              // Title
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    card['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForeignCollabCard(Map<String, dynamic> card) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                card['page'],
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = 0.0;
                  const end = 1.0;
                  const curve = Curves.easeInOut;
                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  var fadeAnimation = animation.drive(tween);
                  return FadeTransition(opacity: fadeAnimation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 252,
          height: 363,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image with scale animation on hover
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: Image.asset(
                    card['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                      stops: const [0.1, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),
                // Content
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title with animation
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 30 * (1 - value)),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: Text(
                            card['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // View More Button with animation
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
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
        ),
      ),
    );
  }

  Widget _buildQuickLinkCard(
    BuildContext context,
    String title,
    Widget icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForeignCollaborationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Text(
            'Foreign Collaborations',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 400, // Slightly taller to accommodate the title and spacing
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: _foreignCollabCards.length,
            itemBuilder: (context, index) {
              return _buildForeignCollabCard(_foreignCollabCards[index]);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildFeedbackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FeedbackPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 251, 191, 191),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: const Color.fromARGB(
            255,
            251,
            191,
            191,
          ).withOpacity(0.3),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.feedback_outlined, size: 20),
            SizedBox(width: 12),
            Text(
              'Share Your Feedback',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Image.asset('assets/image/ggu1-logo.png', height: 50),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/menu.png', width: 30, height: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuPage()),
              );
            },
          ),
        ],
      ),
      body: _hasError
          ? const Center(child: Text('Failed to load video'))
          : _isInitialized
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 450,
                    height: 240,
                    child: VideoPlayer(_controller),
                  ),
                  // Welcome Message Card with Marquee
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 24.0,
                    ),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SizedBox(
                        height: 50, // Constrain the height of the marquee
                        child: Marquee(
                          text:
                              'Welcome to the GGU Experience App! We are delighted to have you here. Explore the various sections to learn more about our university.   ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          blankSpace: 20.0,
                          velocity: 50.0,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: const Duration(
                            milliseconds: 500,
                          ),
                          decelerationCurve: Curves.easeOut,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'QUICK LINKS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.6,
                      children: [
                        _buildQuickLinkCard(
                          context,
                          'Campus Life',
                          Image.asset(
                            'assets/icons/school.png',
                            width: 36,
                            height: 36,
                          ),
                          const Color.fromARGB(255, 251, 191, 191),
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CampusLifePage(),
                            ),
                          ),
                        ),
                        _buildQuickLinkCard(
                          context,
                          'Admissions',
                          Image.asset(
                            'assets/icons/departmen.png',
                            width: 36,
                            height: 36,
                          ),
                          const Color.fromARGB(255, 193, 244, 224),
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdmissionsPage(),
                            ),
                          ),
                        ),
                        _buildQuickLinkCard(
                          context,
                          'Placements & Training',
                          Image.asset(
                            'assets/icons/hiring.png',
                            width: 36,
                            height: 36,
                          ),
                          const Color.fromARGB(255, 254, 211, 248),
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlacementsPage(),
                            ),
                          ),
                        ),
                        _buildQuickLinkCard(
                          context,
                          'Accreditations & Awards',
                          Image.asset(
                            'assets/icons/certificate.png',
                            width: 36,
                            height: 36,
                          ),
                          const Color.fromARGB(255, 188, 232, 252),
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccreditationsPage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                    child: Text(
                      'Our Campuses',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300, // Adjust height as needed
                    child: PageView.builder(
                      controller: _carouselController,
                      onPageChanged: _onPageChanged,
                      itemCount: _campusCards.length,
                      itemBuilder: (context, index) {
                        return _buildCampusCard(_campusCards[index]);
                      },
                    ),
                  ),
                  // Page indicators
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _campusCards.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentCarouselIndex == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  _buildForeignCollaborationsSection(),
                  _buildFeedbackButton(),
                  const SizedBox(height: 32),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
