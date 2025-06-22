import 'package:flutter/material.dart';
import 'package:gguexpo/pages/menu_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gguexpo/tabs/team_page.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TeamPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 241, 205, 205),
        child: const Icon(Icons.people, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/image/ggu college.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Get in Touch',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
            _buildContactCard(
              context: context,
              icon: Icons.email,
              title: 'Email',
              subtitle: 'info@ggu.edu.in',
              url: 'mailto:info@ggu.edu.in',
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              context: context,
              icon: Icons.phone,
              title: 'Phone',
              subtitle: '+91 9949993483',
              url: 'tel:+919949993483',
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              context: context,
              icon: Icons.language,
              title: 'Website',
              subtitle: 'ggu.edu.in',
              url: 'https://ggu.edu.in',
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              context: context,
              icon: Icons.location_on,
              title: 'Address',
              subtitle:
                  'Godavari Global University, NH-16, Chaitanya Knowledge City, Rajamahendravaram, Andhra Pradesh 533296',
              url:
                  'https://www.google.com/maps/place/Godavari+Global+University/@17.0599796,81.8657425,17z/data=!3m1!4b1!4m6!3m5!1s0x3a379f6221208cd9:0xd719ebacd3af5c58!8m2!3d17.0599796!4d81.8683174!16s%2Fm%2F0138mwtj?entry=ttu&g_ep=EgoyMDI1MDYxMC4xIKXMDSoASAFQAw%3D%3D',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _launchURL(context, url),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Color.fromARGB(255, 234, 159, 159)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// Move _launchURL outside the widget
Future<void> _launchURL(BuildContext context, String url) async {
  try {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('An error occurred')));
  }
}
