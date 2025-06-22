import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class GDPage extends StatefulWidget {
  const GDPage({super.key});

  @override
  State<GDPage> createState() => _GDPageState();
}

class _GDPageState extends State<GDPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _imagePaths = [
    'assets/image/gd.webp',
    'assets/image/gd2.png',
    'assets/image/gd3.png',
  ];
  Future<void> _launchMaps() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/place/GIET+DEGREE+COLLEGE/@17.0654078,81.8627058,16z/data=!4m10!1m2!2m1!1sgiet+engineering+college!3m6!1s0x3a379f7d2f98ed2f:0x532c33b26b834f7a!8m2!3d17.0708361!4d81.8684167!15sChhnaWV0IGVuZ2luZWVyaW5nIGNvbGxlZ2VaGiIYZ2lldCBlbmdpbmVlcmluZyBjb2xsZWdlkgEHY29sbGVnZZoBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VOaGJuSkxPRmRuRUFFqgFfEAEqHCIYZ2lldCBlbmdpbmVlcmluZyBjb2xsZWdlKAAyHxABIhuIqRyvHWY2pvllLNSOXsAj09-un9EtQ0uVDjsyHBACIhhnaWV0IGVuZ2luZWVyaW5nIGNvbGxlZ2XgAQD6AQQIABA8!16s%2Fg%2F11f5vchgs7?entry=ttu&g_ep=EgoyMDI1MDYwOS4xIKXMDSoASAFQAw%3D%3D',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giet Degree College',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 241, 205, 205),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            SizedBox(
              height: 218,
              width: 412,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _imagePaths.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(_imagePaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: _imagePaths.length,
                        effect: const WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.white,
                          dotColor: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // College Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Giet Degree College',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'GIET Degree College, established in 2017, is a forward-thinking institution committed to providing quality education and fostering holistic development. The college offers a range of undergraduate programs designed to equip students with the knowledge, skills, and ethical values needed to excel in their chosen fields. With a focus on innovative teaching methods, a supportive learning environment, and a diverse student body, GIET Degree College aims to nurture future leaders and professionals. The college’s state-of-the-art facilities and experienced faculty ensure that students receive a comprehensive education that balances academic rigor with practical experience.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 8),
                  _buildContactItem(Icons.phone, '+91 9949993483'),
                  _buildContactItem(Icons.email, 'info@giet.edu'),
                  _buildContactItem(Icons.language, 'www.giet.edu'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchMaps,
        backgroundColor: const Color.fromARGB(255, 251, 191, 191),
        child: const Icon(Icons.location_on, color: Colors.white),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFFE57373)),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
