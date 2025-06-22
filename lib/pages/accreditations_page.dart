import 'package:flutter/material.dart';

class AccreditationsPage extends StatelessWidget {
  const AccreditationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accreditations & Awards',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 241, 197, 197),
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: accreditations.length,
                itemBuilder: (context, index) {
                  final accreditation = accreditations[index];
                  return GestureDetector(
                    onTap: () {
                      // Add any onTap functionality here if needed
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: AspectRatio(
                        aspectRatio: 384 / 221,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  accreditation.imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.5, 1.0],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  right: 12,
                                  child: Text(
                                    accreditation.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}

class Accreditation {
  final String title;
  final String imagePath;

  const Accreditation({required this.title, required this.imagePath});
}

final List<Accreditation> accreditations = [
  const Accreditation(
    title: 'NAAC A++ Grade',
    imagePath: 'assets/image/NAAC-A.png',
  ),
  const Accreditation(
    title: 'ASSOCHAM',
    imagePath: 'assets/image/ASSOCHAM.png',
  ),
  const Accreditation(title: 'AIM', imagePath: 'assets/image/niti-aayog.png'),
  const Accreditation(
    title: 'INDIA TODAY',
    imagePath: 'assets/image/India-Today.png',
  ),
  const Accreditation(
    title: 'TIMES BUSINESS AWARDS',
    imagePath: 'assets/image/Times-Business-Award.png',
  ),
  const Accreditation(title: 'MSME', imagePath: 'assets/image/meme.png'),
];
