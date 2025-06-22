import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Team Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // A clean, modern font
      ),
      home: const TeamPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Developer Team',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A), // Darker text for better contrast
          ),
        ),
        backgroundColor: const Color.fromARGB(
          255,
          255,
          205,
          205,
        ), // A clean white app bar
        centerTitle: true,
        elevation: 1.0, // Subtle shadow for the app barR
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      body: Container(
        // Using a solid, light background color for a cleaner look
        color: const Color(0xFFF9FAFB),
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ), // Increased padding for more space
          child: GridView.count(
            // Responsive cross axis count based on screen width
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            // **ADJUSTED**: Increased aspect ratio to make cards shorter
            childAspectRatio: MediaQuery.of(context).size.width > 600
                ? 1.2
                : 1.1,
            children: [
              _buildTeamMemberCard(
                context,
                'Vinay kumar',
                'Designer & Developer',
                'vinaykumarmvk17@gmail.com',
                Icons.code_rounded,
              ),
              _buildTeamMemberCard(
                context,
                'Mahesh',
                'Frontend Developer',
                'maheshpeethala62@gmail.com',
                Icons.web_rounded,
              ),
              _buildTeamMemberCard(
                context,
                'Alekhya',
                'Backend Developer',
                'alekhyakada09@gmail.com',
                Icons.storage_rounded,
              ),
              _buildTeamMemberCard(
                context,
                'Meghana',
                'Mobile App Developer',
                'meesalameghana78@gmail.com',
                Icons.smartphone_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the card widget for a single team member.
  Widget _buildTeamMemberCard(
    BuildContext context,
    String name,
    String role,
    String email,
    IconData icon,
  ) {
    return Card(
      // Increased elevation for a more pronounced shadow
      elevation: 6,
      // Added a subtle shadow color for depth
      shadowColor: const Color.fromARGB(255, 221, 154, 154).withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ), // More rounded corners
      child: Container(
        // Using a simple white background inside the card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          // **ADJUSTED**: Reduced padding to decrease card size
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // **ADJUSTED**: Reduced padding for icon container
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // A soft gradient for the icon background
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFDECEC),
                      const Color.fromARGB(255, 255, 223, 223),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  // **ADJUSTED**: Reduced icon size
                  size: 40,
                  // A stronger color for the icon
                  color: const Color.fromARGB(255, 218, 92, 92),
                ),
              ),
              // **ADJUSTED**: Reduced spacing
              const SizedBox(height: 16),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20, // Reduced font size slightly
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                role,
                style: TextStyle(
                  fontSize: 15, // Reduced font size slightly
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(), // Pushes the email to the bottom
              _buildInfoRow(Icons.email_outlined, email),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the info row for email.
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
