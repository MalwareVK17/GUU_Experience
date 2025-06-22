import 'package:flutter/material.dart';
import 'package:gguexpo/pages/menu_page.dart';
import 'package:gguexpo/pages/admissions_page.dart'; // Import AdmissionsPage

class Course {
  final String title;
  final String description;
  final String duration;
  final String imageUrl;
  final Color color;

  Course({
    required this.title,
    required this.description,
    required this.duration,
    required this.imageUrl,
    required this.color,
  });
}

class CoursesPage extends StatelessWidget {
  final List<Course> courses = [
    Course(
      title: 'B.Tech',
      description: 'Bachelor of Technology in various specializations',
      duration: '4 Years',
      imageUrl: 'assets/images/btech.jpg',
      color: const Color.fromARGB(255, 255, 172, 48),
    ),
    Course(
      title: 'MBA',
      description: 'Master of Business Administration',
      duration: '2 Years',
      imageUrl: 'assets/images/mba.jpg',
      color: const Color.fromARGB(255, 114, 143, 249),
    ),
    Course(
      title: 'BBA',
      description: 'Bachelor of Business Administration',
      duration: '3 Years',
      imageUrl: 'assets/images/bba.jpg',
      color: const Color.fromARGB(255, 189, 246, 124),
    ),
    Course(
      title: 'BCA',
      description: 'Bachelor of Computer Applications',
      duration: '3 Years',
      imageUrl: 'assets/images/bca.jpg',
      color: const Color.fromARGB(255, 251, 227, 147),
    ),
    Course(
      title: 'MCA',
      description: 'Master of Computer Applications',
      duration: '2 Years',
      imageUrl: 'assets/images/mca.jpg',
      color: const Color.fromARGB(255, 155, 236, 247),
    ),
    Course(
      title: 'M.Tech',
      description: 'Master of Technology in various specializations',
      duration: '2 Years',
      imageUrl: 'assets/images/mtech.jpg',
      color: const Color.fromARGB(255, 255, 171, 171),
    ),
    Course(
      title: 'Diploma',
      description: 'Diploma in various specializations',
      duration: '3 Years',
      imageUrl: 'assets/images/diploma.jpg',
      color: const Color.fromARGB(255, 248, 174, 237),
    ),
    Course(
      title: 'Degree',
      description: 'Degree in various specializations',
      duration: '3 Years',
      imageUrl: 'assets/images/degree.jpg',
      color: const Color.fromARGB(255, 198, 238, 178),
    ),
    Course(
      title: 'Pharmacy',
      description: 'Pharmacy in various specializations',
      duration: '3 Years',
      imageUrl: 'assets/images/pharmacy.jpg',
      color: const Color.fromARGB(255, 175, 173, 253),
    ),
  ];

  CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courses',
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
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: InkWell(
              onTap: () {
                // Handle course tap
                _showCourseDetails(context, course);
              },
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    colors: [course.color, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course icon/thumbnail
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            course.title[0],
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Course details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              course.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  course.duration,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCourseDetails(BuildContext context, Course course) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Text(
              course.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              course.description,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20.0),
            _buildDetailRow(Icons.schedule, 'Duration', course.duration),
            const SizedBox(height: 10.0),
            _buildDetailRow(Icons.school, 'Degree', 'Bachelor\'s Degree'),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdmissionsPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBBFBF),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20.0, color: Colors.grey[600]),
        const SizedBox(width: 10.0),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
