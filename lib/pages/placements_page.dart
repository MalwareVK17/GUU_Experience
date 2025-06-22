import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacementsPage extends StatefulWidget {
  const PlacementsPage({super.key});

  @override
  State<PlacementsPage> createState() => _PlacementsPageState();
}

class _PlacementsPageState extends State<PlacementsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // FIXED: Added missing keys ('programs', 'duration', 'package', 'roles') to the company data.
  // The first 3 are treated as "Training Partners" and the rest as "Recruiters".
  final List<Map<String, String>> companies = [
    {
      'name': 'Tech Wing',
      'image': 'assets/image/tw2.png',
      'website': 'https://techwing.org/welcome',
      'programs': 'Mobile App Development,AWS,JFSD,Gen AI,UI/UX Design',
      'duration': '3-6 Months',
    },
    {
      'name': 'TCS',
      'image': 'assets/image/tcs3.jpg',
      'website': 'https://www.tcs.com/',
      'package': 'TCS iON, CodeVita',
    },
    {
      'name': 'Wipro',
      'image': 'assets/image/Wipro.jpg',
      'website': 'https://www.wipro.com/',
      'package': 'Elite NTH, TalentNext',
    },
    {
      'name': 'Tech Mahindra',
      'image': 'assets/image/TM.png',
      'website': 'https://www.techmahindra.com/',
      'package': 'Up to 5.5 LPA',
    },
    {
      'name': 'Bonfiglioli',
      'image': 'assets/image/bonfigoli.jpg',
      'website': 'https://careers.bonfiglioli.com/',
      'package': 'Up to 4.75 LPA',
    },
    {
      'name': 'Accenture',
      'image': 'assets/image/accenture.jpg',
      'website': 'https://www.accenture.com/in-en/careers',
      'package': 'Up to 6.5 LPA',
    },
    {
      'name': 'Infosys',
      'image': 'assets/image/infosys.jpg',
      'website': 'https://www.infosys.com/careers.html',
      'package': 'Up to 7 LPA',
    },
    {
      'name': 'Cognizant',
      'image': 'assets/image/cognizant.jpg',
      'website': 'https://careers.cognizant.com/global-en/',
      'package': 'Up to 4.5 LPA',
    },
    {
      'name': 'Capgemini',
      'image': 'assets/image/capgemini.jpg',
      'website':
          'https://www.capgemini.com/careers/join-capgemini/job-search/?size=15',
      'package': 'Up to 7.5 LPA',
    },
    {
      'name': 'Virtusa',
      'image': 'assets/image/virtusa.jpg',
      'website': 'https://www.virtusa.com/careers',
      'package': 'Up to 7 LPA',
    },
  ];

  final List<String> _imagePaths = [
    'assets/image/GGU-popup.jpg',
    'assets/image/gguv1.png',
    'assets/image/otpg.png',
    'assets/image/ibmggu.jpg',
  ];

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
      if (!mounted) return;
      int nextPage = _currentPage + 1;
      if (nextPage >= _imagePaths.length) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  // FIXED: Improved URL launching with better error handling and mobile compatibility
  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);

      // Check if the URL can be launched
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode
              .externalApplication, // This ensures it opens in external browser
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
          ),
        );
      } else {
        // Fallback: try to launch with platform default
        await launchUrl(url, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      // Show error dialog if URL launching fails
      if (mounted) {
        _showErrorDialog(
          'Could not open the website. Please check your internet connection and try again.',
        );
      }
    }
  }

  // Helper method to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrainingPartnerCard(Map<String, String> partner) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Company Logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  partner['image']!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.school,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Training Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    partner['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Programs: ${partner['programs']}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Duration: ${partner['duration']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Visit Website Button - FIXED: Added loading state
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Show loading indicator while launching URL
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        await _launchURL(partner['website']!);

                        // Hide loading indicator
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'View Programs',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildRecruiterCard(Map<String, String> recruiter) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Company Logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  recruiter['image']!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.business,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Recruiter Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recruiter['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green[200]!, width: 1),
                    ),
                    child: Text(
                      'Package: ${recruiter['package']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Visit Website Button - FIXED: Added loading state
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Show loading indicator while launching URL
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        await _launchURL(recruiter['website']!);

                        // Hide loading indicator
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9A9E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Visit Website',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Placements & Training',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 241, 205, 205),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Container(
              height: 200,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: _imagePaths.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          _imagePaths[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey[500],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 12,
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

            const SizedBox(height: 8),

            // Training Partners Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Our Training Partners',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Training Partners Cards
            ...companies
                .take(1)
                .map((company) => _buildTrainingPartnerCard(company)),

            const SizedBox(height: 24),

            // Top Recruiters Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Our Top Recruiters',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Recruiter Cards
            ...companies.skip(1).map((company) => _buildRecruiterCard(company)),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
