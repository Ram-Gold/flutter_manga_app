import 'package:flutter/material.dart';

class BrowserScreen extends StatelessWidget {
  const BrowserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A), // Unified Background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Title
              const Text(
                'Browse',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // 2. Search Bar
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C2A), // Unified Color
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search Manga',
                    hintStyle: TextStyle(color: Color(0xFFA6A6BB)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFA6A6BB)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 3. Genre Label
              const Text(
                'Genre',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // 4. Genre Chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCustomChip('Action'),
                    _buildCustomChip('Romance'),
                    _buildCustomChip('Sci-Fi'),
                    _buildCustomChip('Mystery'),
                    _buildCustomChip('Thriller'),
                    _buildCustomChip('Supernatural'),
                    _buildCustomChip('Comedy'),
                    _buildCustomChip('Music'),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 5. Recommended Section
              const Text(
                "Recommended for You",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _mangaList.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final manga = _mangaList[index];
                    return _buildMangaItem(manga);
                  },
                ),
              ),

              const SizedBox(height: 30),

              // 6. Recently Added Section
              const Text(
                "Recently Added",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _recentlyAddedList.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final manga = _recentlyAddedList[index];
                    return _buildMangaItem(manga);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Unified Custom Chip UI
  Widget _buildCustomChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF323240) : const Color(0xFF1C1C2A), // Unified
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

  // Manga Item UI
  Widget _buildMangaItem(Map<String, String> manga) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              manga["imagePath"]!,
              height: 180,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            manga["title"]!,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            manga["author"]!,
            style: const TextStyle(color: Color(0xFFA6A6BB)),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Data Lists
final List<Map<String, String>> _mangaList = [
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

final List<Map<String, String>> _recentlyAddedList = [
  {
    "title": "Jujutsu Kaisen",
    "author": "Gege Akutami",
    "imagePath": "assets/images/jjk.jpg",
  },
  {
    "title": "DanDaDan",
    "author": "Yukinobu Tatsu",
    "imagePath": "assets/images/dandadan.jpg",
  },
  {
    "title": "One Piece",
    "author": "Eiichiro Oda",
    "imagePath": "assets/images/onepiece.jpg",
  },
];