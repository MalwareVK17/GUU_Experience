import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gguexpo/pages/menu_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoading = false;

  final List<String> _tabs = ['Campus', 'Events', 'Sports', 'Transport'];

  // Sample gallery data - replace with actual image paths
  final Map<String, List<String>> _galleryData = {
    'Campus': [
      'assets/image/gd.webp',
      'assets/image/gec.jpg',
      'assets/image/gec1.jpg',
      'assets/image/canteen2.png',
      'assets/image/building1.png',
      'assets/image/mca3.jpeg',
      'assets/image/overall.png',
      'assets/image/hostal2.png',
      'assets/image/hostal3.png',
      'assets/image/hos.jpeg',
      'assets/image/rk.png',
      'assets/image/grk2.jpeg',
      'assets/image/del.png',
      'assets/image/gpc3.jpg',
      'assets/image/gguf.jpg',
      'assets/image/ggu5.jpeg',
      'assets/image/ggu4.jpg',
      'assets/image/ggu2.png',
    ],
    'Events': [
      'assets/image/club.jpeg',
      'assets/image/sev.jpg',
      'assets/image/mev.jpg',
      'assets/image/evcm.png',
      'assets/image/Event2.png',
      'assets/image/eve8.png',
      'assets/image/eve9.png',
      'assets/image/eve10.png',
      'assets/image/eve11.png',
      'assets/image/eve12.png',
      'assets/image/eve13.png',
      'assets/image/eve14.png',
      'assets/image/allu.png',
      'assets/image/anasuuya.png',
      'assets/image/singers.png',
    ],
    'Sports': [
      'assets/image/sport2.jpeg',
      'assets/image/spv.jpg',
      'assets/image/ground.png',
      'assets/image/se.png',
      'assets/image/sp.png',
    ],
    'Transport': [
      'assets/image/bus.jpg',
      'assets/image/cycle2.jpg',
      'assets/image/bus2.jpg',
      'assets/image/life.jpg',
      'assets/image/buggy.jpg',
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _searchQuery = '';
          _searchController.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _filteredImages {
    final currentTab = _tabs[_tabController.index];
    final images = _galleryData[currentTab] ?? [];

    if (_searchQuery.isEmpty) return images;

    return images.where((image) {
      return image.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _showFullScreenImage(String imagePath, String tag) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          body: Center(
            child: PhotoView(
              imageProvider: AssetImage(imagePath),
              heroAttributes: PhotoViewHeroAttributes(tag: tag),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              enableRotation: true,
              loadingBuilder: (context, event) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1)); // Simulate refresh
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'University Gallery',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
          ),
          labelColor: const Color.fromARGB(255, 0, 0, 0),
          unselectedLabelColor: const Color.fromARGB(255, 0, 0, 0),
          indicatorColor: const Color.fromARGB(255, 0, 0, 0),
          indicatorWeight: 3,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/menu.png',
              width: 30,
              height: 30,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuPage()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search images...',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            setState(() {
                              _searchQuery = '';
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredImages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_library,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'No images found',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            3, // CHANGED: 3 columns instead of 2 for smaller cards
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            1.0, // CHANGED: Square aspect ratio for compact cards
                      ),
                      itemCount: _filteredImages.length,
                      itemBuilder: (context, index) {
                        final imagePath = _filteredImages[index];
                        final tag =
                            'image_${_tabs[_tabController.index]}_$index';

                        return GestureDetector(
                          onTap: () => _showFullScreenImage(imagePath, tag),
                          child: Hero(
                            tag: tag,
                            child: Container(
                              // ADDED: Container with shadow decoration
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit
                                      .cover, // ENSURES: Full image coverage in card
                                  width: double.infinity,
                                  height: double.infinity,
                                  // OPTIMIZED: Cache for better performance
                                  cacheWidth: 200,
                                  cacheHeight: 200,
                                  frameBuilder:
                                      (
                                        context,
                                        child,
                                        frame,
                                        wasSynchronouslyLoaded,
                                      ) {
                                        if (frame == null) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        }
                                        return child;
                                      },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 30,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onRefresh,
        backgroundColor: const Color.fromARGB(255, 242, 167, 167),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
