import 'package:flutter/material.dart';

class LibraryManga extends StatelessWidget {
  final List<Map<String, String>> _libraryList = [
    {
      "title": "Uma Musume - Pretty Derby: Star Blossom",
      "author": "Monjūsaki , Cygames, Hotani Shin",
      "imagePath": "assets/images/Pretty Derby.jpg",
    },
    {
      "title": "Shin Ootaka, Homare",
      "author": "Monjūsaki , Cygames, Hotani Shin",
      "imagePath": "assets/images/Shin Ootaka, Homare.jpg",
    },
    {
      "title": "Oshi no Ko",
      "author": "Akasaka Aka, Yokoyari Mengo",
      "imagePath": "assets/images/Oshi no Ko.jpg",
    },
    {
      "title": "Uma Musume: Cinderella Gray",
      "author": "Sugiura Masafumi, Itou Junnousuke, Kuzumi Taiyou",
      "imagePath": "assets/images/Cinderella Gray.jpg",
    },
  ];

  LibraryManga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A), // Main Background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Library',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Search Bar
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C2A), // Card/Container Color
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search Library',
                    hintStyle: TextStyle(color: Color(0xFFA6A6BB)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFA6A6BB)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCustomChip('Ongoing' ), 
                    _buildCustomChip('Planning'),
                    _buildCustomChip('Reading'),
                    _buildCustomChip('Completed'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Manga Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _libraryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.50,
                ),
                itemBuilder: (context, index) {
                  final manga = _libraryList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF1C1C2A), // Consistent card color
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              manga["imagePath"]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        manga["title"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF323240) : const Color(0xFF1C1C2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFFA6A6BB),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}