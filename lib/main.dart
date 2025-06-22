import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gguexpo/home_page.dart';
import 'package:gguexpo/tabs/gallery_page.dart';
import 'package:gguexpo/tabs/courses_page.dart';
import 'package:gguexpo/tabs/contactus_page.dart';
import 'package:gguexpo/tabs/dashboard_page.dart';
import 'package:gguexpo/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GGU Expo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IconModel {
  final dynamic icon;
  final String name;
  final bool isImage;
  final Widget Function() pageBuilder; // FIXED: Use function instead of widget

  const IconModel({
    required this.icon,
    required this.name,
    this.isImage = false,
    required this.pageBuilder,
  });

  Map<String, dynamic> toJson() {
    return {
      'icon': isImage ? icon.toString() : (icon as IconData).codePoint,
      'name': name,
      'isImage': isImage,
      'page': pageBuilder().runtimeType.toString(),
    };
  }

  IconModel copyWith({
    dynamic icon,
    String? name,
    bool? isImage,
    Widget Function()? pageBuilder,
  }) {
    return IconModel(
      icon: icon ?? this.icon,
      name: name ?? this.name,
      isImage: isImage ?? this.isImage,
      pageBuilder: pageBuilder ?? this.pageBuilder,
    );
  }

  @override
  String toString() {
    return 'IconModel(name: $name, isImage: $isImage, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IconModel &&
        other.icon == icon &&
        other.name == name &&
        other.isImage == isImage;
  }

  @override
  int get hashCode {
    return icon.hashCode ^ name.hashCode ^ isImage.hashCode;
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  late AnimationController _animationController;
  late Animation<double> _animation;

  // FIXED: Use lazy initialization for better performance
  late final List<Widget> _tabs;
  late final List<IconModel> _sampleIcons;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // FIXED: Use builders instead of const constructors
    _tabs = [
      const HomePage(),
      CoursesPage(), // REMOVED const - this was causing the error
      const GalleryPage(),
      const DashboardPage(),
      const ContactUsPage(),
    ];

    // FIXED: Use function builders for better memory management
    _sampleIcons = [
      const IconModel(
        icon: 'assets/icons/home-page.png',
        name: "Home",
        isImage: true,
        pageBuilder: HomePage.new,
      ),
      const IconModel(
        icon: 'assets/icons/graduation.png',
        name: "Academics",
        isImage: true,
        pageBuilder: CoursesPage.new, // FIXED: Use constructor reference
      ),
      const IconModel(
        icon: 'assets/icons/gallery.png',
        name: "Gallery",
        isImage: true,
        pageBuilder: GalleryPage.new,
      ),
      const IconModel(
        icon: 'assets/icons/dashboard.png',
        name: "Dashboard",
        isImage: true,
        pageBuilder: DashboardPage.new,
      ),
      const IconModel(
        icon: 'assets/icons/customer-service.png',
        name: "Support",
        isImage: true,
        pageBuilder: ContactUsPage.new,
      ),
    ];

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Widget> _buildNavigationItems() {
    return _sampleIcons.map<Widget>((iconModel) {
      if (iconModel.isImage) {
        return Container(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            iconModel.icon as String,
            width: 24,
            height: 24,
            color: const Color.fromARGB(255, 71, 4, 4),
            fit: BoxFit.contain,
            // OPTIMIZED: Cache images for better performance
            cacheWidth: 48,
            cacheHeight: 48,
            errorBuilder: (context, error, stackTrace) {
              IconData fallbackIcon;
              switch (iconModel.name.toLowerCase()) {
                case 'home':
                  fallbackIcon = Icons.home;
                  break;
                case 'academics':
                  fallbackIcon = Icons.school;
                  break;
                case 'gallery':
                  fallbackIcon = Icons.photo_library;
                  break;
                case 'dashboard':
                  fallbackIcon = Icons.dashboard;
                  break;
                case 'support':
                  fallbackIcon = Icons.support_agent;
                  break;
                default:
                  fallbackIcon = Icons.error;
              }

              return Icon(
                fallbackIcon,
                size: 24,
                color: const Color.fromARGB(255, 71, 4, 4),
              );
            },
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            iconModel.icon as IconData,
            size: 24,
            color: const Color.fromARGB(255, 71, 4, 4),
          ),
        );
      }
    }).toList();
  }

  void _onPageChanged(int index) {
    if (index != _page) {
      setState(() {
        _page = index;
      });

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // OPTIMIZED: Wrap in RepaintBoundary for better performance
      bottomNavigationBar: RepaintBoundary(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            items: _buildNavigationItems(),
            index: _page,
            height: 60.0,
            color: const Color.fromARGB(255, 255, 254, 254),
            buttonBackgroundColor: const Color.fromARGB(255, 247, 117, 117),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOutCubic,
            animationDuration: const Duration(milliseconds: 400),
            onTap: _onPageChanged,
            letIndexChange: (index) => true,
          ),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _animation,
          child: IndexedStack(index: _page, children: _tabs),
        ),
      ),
    );
  }
}

class StartupBenchmarks {
  static const Duration targetColdStart = Duration(seconds: 2);
  static const Duration targetWarmStart = Duration(milliseconds: 500);
  static const Duration targetHotReload = Duration(milliseconds: 100);

  // Measure actual startup time in main()
  static void measureStartup() {
    final stopwatch = Stopwatch()..start();
    // Your app initialization code here
    stopwatch.stop();
    print('Startup time: ${stopwatch.elapsedMilliseconds}ms');
  }
}

// 2. RENDERING PERFORMANCE BENCHMARKS
// Target: 60 FPS (16.67ms per frame) on most devices
class RenderingBenchmarks {
  static const double targetFPS = 60.0;
  static const Duration targetFrameTime = Duration(microseconds: 16667);

  // Key metrics to monitor:
  // - Frame build time < 16ms
  // - No dropped frames during animations
  // - Smooth scrolling (no jank)
  // - Efficient widget rebuilds
}

// 3. MEMORY USAGE BENCHMARKS
class MemoryBenchmarks {
  // Target: < 100MB for typical mobile app
  static const int targetMemoryUsageMB = 100;
  static const int maxMemoryLeaksMB = 10;

  // Monitor:
  // - Heap usage
  // - Image cache size
  // - Widget tree depth
  // - Retained objects
}

// 4. NETWORK PERFORMANCE BENCHMARKS
class NetworkBenchmarks {
  static const Duration targetAPIResponse = Duration(milliseconds: 1000);
  static const Duration targetImageLoad = Duration(milliseconds: 500);
  static const int maxRetries = 3;

  // Key metrics:
  // - API response times
  // - Image loading times
  // - Offline functionality
  // - Error handling
}

// 5. BATTERY USAGE BENCHMARKS
class BatteryBenchmarks {
  // Target: < 5% battery drain per hour of usage
  static const double targetBatteryDrainPerHour = 5.0;

  // Monitor:
  // - CPU usage
  // - GPU usage
  // - Network usage
  // - Background processing
}

// 6. USER INTERACTION BENCHMARKS
class InteractionBenchmarks {
  static const Duration targetTapResponse = Duration(milliseconds: 100);
  static const Duration targetPageTransition = Duration(milliseconds: 300);
  static const Duration targetScrollResponse = Duration(milliseconds: 16);

  // Key metrics:
  // - Touch response time
  // - Animation smoothness
  // - Gesture recognition
  // - Feedback timing
}
