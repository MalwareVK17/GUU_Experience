import 'package:flutter/material.dart';
import 'package:gguexpo/pages/menu_page.dart';
import 'dart:math';
import 'dart:async';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'University Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: false,
        elevation: 0,
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
      body: const UniversityDashboard(),
    );
  }
}

// Utility functions for chart data generation
List<Map<String, dynamic>> generateBarChartData() {
  final random = Random();
  final categories = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return categories
      .map(
        (day) => {
          'day': day,
          'value': random.nextInt(60) + 40, // Values between 40-100
        },
      )
      .toList();
}

// Fixed campus distribution data
List<Map<String, dynamic>> getFixedCampusDistribution() {
  return [
    {
      'category': 'Students',
      'value': 15000,
      'color': const Color(0xFF2196F3), // Blue
    },
    {
      'category': 'Faculty',
      'value': 250,
      'color': const Color(0xFF4CAF50), // Green
    },
    {
      'category': 'Staff',
      'value': 150,
      'color': const Color(0xFFFF9800), // Orange
    },
    {
      'category': 'Visitors',
      'value': 70,
      'color': const Color(0xFF9C27B0), // Purple
    },
  ];
}

List<int> generateLineChartData({int points = 7}) {
  final random = Random();
  return List.generate(points, (index) => random.nextInt(100));
}

class UniversityDashboard extends StatefulWidget {
  const UniversityDashboard({super.key});

  @override
  State<UniversityDashboard> createState() => _UniversityDashboardState();
}

class _UniversityDashboardState extends State<UniversityDashboard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Fixed carousel data
  final List<Map<String, String>> carouselItems = [
    {
      'title': 'University Campus',
      'image': 'assets/image/Building1.png',
      'description': 'Modern infrastructure with state-of-the-art facilities',
    },
    {
      'title': 'Student Life',
      'image': 'assets/image/stl.png',
      'description': 'Vibrant campus life with diverse activities',
    },
    {
      'title': 'Academic Excellence',
      'image': 'assets/image/ggut.jpeg',
      'description': 'Committed to quality education and research',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < carouselItems.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pieData = getFixedCampusDistribution();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced Image Carousel Card
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemCount: carouselItems.length,
                        itemBuilder: (context, index) {
                          return _buildEnhancedCarouselItem(
                            carouselItems[index]['title']!,
                            carouselItems[index]['image']!,
                            carouselItems[index]['description']!,
                          );
                        },
                      ),
                    ),
                    // Enhanced Page Indicators
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(carouselItems.length, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: _currentPage == index
                                  ? Colors.blue
                                  : Colors.grey[300],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // University Achievements
            _buildAchievementRow(context, [
              _buildAchievementBox(
                context,
                '1998',
                'Established 26 Years Ago',
                Colors.blue[50]!,
                Colors.blue,
              ),
              _buildAchievementBox(
                context,
                '250+',
                'Faculty',
                Colors.green[50]!,
                Colors.green,
              ),
              _buildAchievementBox(
                context,
                '50+',
                'Faculty with PhD',
                Colors.orange[50]!,
                Colors.orange,
              ),
            ]),
            const SizedBox(height: 16),
            _buildAchievementRow(context, [
              _buildAchievementBox(
                context,
                '15000+',
                'Students',
                Colors.purple[50]!,
                Colors.purple,
              ),
              _buildAchievementBox(
                context,
                'NAAC A++',
                'Grade',
                Colors.red[50]!,
                Colors.red,
              ),
              _buildAchievementBox(
                context,
                '3.58/4',
                'CGPA',
                Colors.teal[50]!,
                Colors.teal,
              ),
            ]),
            const SizedBox(height: 16),
            _buildAchievementRow(context, [
              _buildAchievementBox(
                context,
                '3000+',
                'Published Papers',
                Colors.blue[50]!,
                Colors.blue,
              ),
              _buildAchievementBox(
                context,
                '50+',
                'MOUs & Collaborations',
                Colors.pink[50]!,
                Colors.pink,
              ),
              _buildAchievementBox(
                context,
                '2000+',
                'Placements',
                Colors.yellow[50]!,
                Colors.yellow,
              ),
            ]),
            const SizedBox(height: 24),

            // Charts Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildChartCard(
                  context,
                  'Live Statistics',
                  const LiveChart(),
                  width: MediaQuery.of(context).size.width * 0.45,
                ),
                _buildChartCard(
                  context,
                  'Placement Statistics',
                  CustomPaint(
                    size: const Size(double.infinity, 200),
                    painter: PlacementBarChartPainter(),
                  ),
                  width: MediaQuery.of(context).size.width * 0.45,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Enhanced Campus Distribution Card with Fixed Values
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 25,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Enhanced Card Header
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.05),
                          Colors.purple.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blue.shade600],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.pie_chart_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Campus Distribution',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Fixed population breakdown across categories',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Chart and Legend Section
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWideScreen = constraints.maxWidth > 600;

                        if (isWideScreen) {
                          return Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 300,
                                  padding: const EdgeInsets.all(20),
                                  child: Center(
                                    child: SizedBox(
                                      width: 260,
                                      height: 260,
                                      child: CustomPaint(
                                        painter: EnhancedPieChartPainter(
                                          pieData,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: _buildEnhancedLegend(pieData),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Container(
                                height: 260,
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: SizedBox(
                                    width: 220,
                                    height: 220,
                                    child: CustomPaint(
                                      painter: EnhancedPieChartPainter(pieData),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildEnhancedLegend(pieData),
                            ],
                          );
                        }
                      },
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

  Widget _buildEnhancedCarouselItem(
    String title,
    String imagePath,
    String description,
  ) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image with fallback
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.purple.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 64,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Image not found',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Enhanced Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
          // Enhanced Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      height: 1.3,
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

  Widget _buildChartCard(
    BuildContext context,
    String title,
    Widget chart, {
    double? width,
  }) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: chart),
        ],
      ),
    );
  }

  Widget _buildAchievementRow(BuildContext context, List<Widget> boxes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: boxes,
    );
  }

  Widget _buildAchievementBox(
    BuildContext context,
    String value,
    String label,
    Color backgroundColor,
    Color? accentColor,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (accentColor ?? Colors.grey).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (accentColor ?? Colors.grey).withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: accentColor ?? Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedLegend(List<Map<String, dynamic>> pieData) {
    final total = pieData.fold<int>(
      0,
      (sum, item) => sum + (item['value'] as int),
    );

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Enhanced Total count header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.1),
                  Colors.purple.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Text(
                  'Total Population',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  total.toString(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Enhanced Legend items
          ...pieData.map((data) {
            final percentage = ((data['value'] as int) / total * 100)
                .toStringAsFixed(1);
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: data['color'] as Color,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: (data['color'] as Color).withOpacity(0.4),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['category'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${data['value']} people',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: (data['color'] as Color).withOpacity(
                                  0.1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$percentage%',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: data['color'] as Color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Enhanced Pie Chart Painter
class EnhancedPieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  EnhancedPieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 10;
    final total = data.fold<double>(0, (sum, item) => sum + item['value']);

    double startAngle = -pi / 2;

    // Draw shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(center.dx + 2, center.dy + 2),
      radius,
      shadowPaint,
    );

    // Draw pie slices
    for (var item in data) {
      final sweepAngle = (item['value'].toDouble()) / total * 2 * pi;
      final paint = Paint()
        ..color = item['color'] as Color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw slice border
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        borderPaint,
      );

      startAngle += sweepAngle;
    }

    // Draw center circle for donut effect
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.4, centerPaint);

    // Draw center circle border
    final centerBorderPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius * 0.4, centerBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Existing classes remain the same
class LiveChart extends StatefulWidget {
  const LiveChart({super.key});

  @override
  State<LiveChart> createState() => _LiveChartState();
}

class _LiveChartState extends State<LiveChart> {
  late List<int> data;

  @override
  void initState() {
    super.initState();
    data = generateLineChartData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 200),
      painter: LineChartPainter(data),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<int> data;

  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    final maxValue = data.reduce(max).toDouble();
    final minValue = data.reduce(min).toDouble();
    final range = maxValue - minValue;

    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - ((data[i] - minValue) / range) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    final pointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - ((data[i] - minValue) / range) * size.height;
      canvas.drawCircle(Offset(x, y), 5, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class PlacementBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final data = generateBarChartData();
    final maxValue = data.map((e) => e['value'] as int).reduce(max).toDouble();

    final barWidth = size.width / data.length;

    for (int i = 0; i < data.length; i++) {
      final value = data[i]['value'] as int;
      final barHeight = (value / maxValue) * size.height * 0.8;

      final paint = Paint()
        ..color = Colors.orange.withOpacity(0.8)
        ..style = PaintingStyle.fill;

      final rect = Rect.fromLTWH(
        i * barWidth + barWidth * 0.15,
        size.height - barHeight,
        barWidth * 0.7,
        barHeight,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
