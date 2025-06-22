import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class Ggu1Page extends StatefulWidget {
  const Ggu1Page({super.key});

  @override
  State<Ggu1Page> createState() => _Ggu1PageState();
}

class _Ggu1PageState extends State<Ggu1Page> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _imagePaths = [
    'assets/image/gguf.jpg',
    'assets/image/gguv6.jpeg',
    'assets/image/ggu2.png',
    'assets/image/ggu4.jpg',
    'assets/image/ggu5.jpeg',
    'assets/image/pp.png',
  ];

  Future<void> _launchMaps() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/place/Godavari+Global+University/@17.0654078,81.8627058,16z/data=!4m10!1m2!2m1!1sgiet+engineering+college!3m6!1s0x3a379f6221208cd9:0xd719ebacd3af5c58!8m2!3d17.0599796!4d81.8683174!15sChhnaWV0IGVuZ2luZWVyaW5nIGNvbGxlZ2VaGiIYZ2lldCBlbmdpbmVlcmluZyBjb2xsZWdlkgEHY29sbGVnZaoBXxABKhwiGGdpZXQgZW5naW5lZXJpbmcgY29sbGVnZSgAMh8QASIbiKkcrx1mNqb5ZSzUjl7AI9Pfrp_RLUNLlQ47MhwQAiIYZ2lldCBlbmdpbmVlcmluZyBjb2xsZWdl4AEA!16s%2Fm%2F0138mwtj?entry=ttu&g_ep=EgoyMDI1MDYwOS4xIKXMDSoASAFQAw%3D%3D',
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
          'Giet Global University',
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
                    'Godavari Global University (GGU) is an esteemed institution with a rich history, dating back to its establishment in 1998 as the Godavari Institute of Engineering & Technology (GIET). Starting with a humble intake of 180 students, GGU has evolved over the years and, in 2024 it transformed into Godavari Global University. Today, it is recognized as a prominent educational hub in Andhra Pradesh, serving more than 10,000 students from across 15 Indian states and 13 countries.GGU is known for its commitment to academic excellence, as reflected in its NAAC ‘A++’ accreditation with a score of 3.58/4 and its consistent ranking by the National Institutional Ranking Framework (NIRF) since 2019. The university offers diverse curriculum across its three main schools- School of Computing, School of Engineering, and School of Sciences, providing students with holistic education and career opportunities.In addition to its strong academic reputation, GGU is home to 15 Centres of Excellence, developed in collaboration with leading industry partners such as Dassault, Virtusa, and Siemens, offering students cutting-edge skills and industry exposure. The institution’s faculty is highly qualified, ensuring high-quality education and mentorship for its students.GGU is also recognized under Sections 2(f) and 12(b) of the UGC Act 1956, which enhances its credibility and enables collaborations with foreign universities for student exchanges and joint research programs. The university’s infrastructure includes advanced laboratories, modern classrooms, extensive libraries, and comprehensive hostel and transport facilities.',
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
                  _buildFeatureItem(Icons.school, 'NAAC A++ Accredited'),
                  _buildFeatureItem(Icons.language, '50+ Acres Campus'),
                  _buildFeatureItem(Icons.people, '15,000+ Students'),
                  _buildFeatureItem(Icons.engineering, '250+ Faculty Members'),
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
