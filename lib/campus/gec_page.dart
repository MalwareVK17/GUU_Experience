import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class GecPage extends StatefulWidget {
  const GecPage({super.key});

  @override
  State<GecPage> createState() => _GecPageState();
}

class _GecPageState extends State<GecPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _imagePaths = [
    'assets/image/gec.jpg',
    'assets/image/gec1.jpg',
    'assets/image/gec2.png',
    'assets/image/gec4.jpg',
  ];
  Future<void> _launchMaps() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/place/GIET+Engineering+College/@17.0680099,81.8613247,16.25z/data=!4m10!1m2!2m1!1sgiet+polytechnic+college!3m6!1s0x3a379efaaaaaaaab:0xcc218fa6d5dc22b7!8m2!3d17.0690476!4d81.8672947!15sChhnaWV0IHBvbHl0ZWNobmljIGNvbGxlZ2VaGiIYZ2lldCBwb2x5dGVjaG5pYyBjb2xsZWdlkgEQdGVjaG5pY2FsX3NjaG9vbJoBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VSeE4zRlBkR1ozRUFFqgFnCgsvbS8wMTM4bXd0ahABKhciE3BvbHl0ZWNobmljIGNvbGxlZ2UoADIfEAEiG7iQlgA0YYMP1tTY9qn91XPm5PKMUYuqej-IdTIcEAIiGGdpZXQgcG9seXRlY2huaWMgY29sbGVnZeABAPoBBAhoEEg!16s%2Fg%2F11hdc47m8t?entry=ttu&g_ep=EgoyMDI1MDYwOS4xIKXMDSoASAFQAw%3D%3D',
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
          'Giet Engineering College',
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
                    'About Giet Engineering College',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'GIET Engineering College (GEC), Part of GGU: GEC is a constituent college of Godavari Global University, Engineering Focus: GEC primarily offers engineering programs, Undergraduate Programs: GEC provides undergraduate (B.Tech) courses in various engineering specializations, Placement Records: GIET Engineering College has a strong placement record, with major companies participating in campus recruitment drives, Infrastructure and Facilities: GIET Engineering College boasts state-of-the-art facilities, including a sprawling 300-acre campus',
                    style: TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Key Features:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildFeatureItem(Icons.school, 'NAAC A+ Accredited'),
                  _buildFeatureItem(
                    Icons.computer,
                    'State-of-the-art Infrastructure',
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

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFFE57373)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
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
