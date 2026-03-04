import 'package:flutter/material.dart';

class SearchManga extends StatelessWidget {
  final List<Map<String, String>> _searchlist = [
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

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A), 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Iniba ko title from "Library" to "Search"
              const Text(
                'Search',
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
                  color: const Color(0xFF1C1C2A),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search Manga', // Iniba din yung hint text
                    hintStyle: TextStyle(color: Color(0xFFA6A6BB)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFA6A6BB)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // DITO NA TANGGAL YUNG STATUS AT CHIPS LIST

              // Manga Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _searchlist.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.50,
                ),
                itemBuilder: (context, index) {
                  final manga = _searchlist[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF1C1C2A),
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
}