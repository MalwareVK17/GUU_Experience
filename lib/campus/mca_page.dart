import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class McaPage extends StatefulWidget {
  const McaPage({super.key});

  @override
  State<McaPage> createState() => _McaPageState();
}

class _McaPageState extends State<McaPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _imagePaths = [
    'assets/image/mca.png',
    'assets/image/mca2.png',
    'assets/image/mca3.jpeg',
  ];
  Future<void> _launchMaps() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/place/basketball+court/@17.0642623,81.8648565,17.42z/data=!4m9!1m2!2m1!1sgiet+polytechnic+college!3m5!1s0x3a379f622001d33d:0x1b9dbcf3cfdfb13e!8m2!3d17.0621624!4d81.8675114!16s%2Fg%2F11gbkt0prp?entry=ttu&g_ep=EgoyMDI1MDYwOS4xIKXMDSoASAFQAw%3D%3D',
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
          'MCA Block',
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
                    'About Giet Global University',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Godavari Global University (formerly known as Godavari Institute of Engineering and Technology) [GGU], Rajahmundry established in 1998 is a Private University, currently having 201-250 position in NIRF Ranking 2022. GGU Rajahmundry is approved by AICTE and UGC, and is accredited by NBA and NAAC-A+. Admission in Godavari Global University is offered in Engineering, Management and Computer Applications at UG/ PG/ Diploma level..',
                    style: TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Contact Information:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
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
