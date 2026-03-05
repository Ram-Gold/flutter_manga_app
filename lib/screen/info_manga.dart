import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/manga.dart';
import '../providers/manga_provider.dart';
import 'page_manga.dart';

class InfoManga extends StatefulWidget {
  final Manga manga;

  const InfoManga({super.key, required this.manga});

  @override
  State<InfoManga> createState() => _InfoMangaState();
}

class _InfoMangaState extends State<InfoManga> {
  @override
  Widget build(BuildContext context) {
    final mangaProvider = Provider.of<MangaProvider>(context, listen: false);
    
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Manga Cover
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.manga.coverPage,
                        height: 320,
                        width: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      widget.manga.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Authors
                    Text(
                      widget.manga.authors,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFA6A6BB),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Genres
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: widget.manga.genres.map((genre) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C1C2A),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Text(
                          genre,
                          style: const TextStyle(color: Color(0xFFA6A6BB), fontSize: 12),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Rating and Favorites Box
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C2A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Rating
                          Row(
                            children: [
                              const Icon(Icons.star_border, color: Color(0xFFFF7F5C)),
                              const SizedBox(width: 8),
                              Text(
                                widget.manga.rating,
                                style: const TextStyle(
                                  color: Color(0xFFFF7F5C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Divider
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white24,
                          ),
                          // Favorites
                          Row(
                            children: [
                              const Icon(Icons.bookmark_outline, color: Colors.white70),
                              const SizedBox(width: 8),
                              Text(
                                widget.manga.favorites,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Description Label
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Description Text
                    Text(
                      widget.manga.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 120), // Space for bottom bar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Action Bar
      bottomSheet: Container(
        color: const Color(0xFF0F0F1A),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Row(
          children: [
            // Bookmark Button
            GestureDetector(
              onTap: () async {
                await mangaProvider.toggleBookmark(widget.manga);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF25253D),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  widget.manga.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: widget.manga.isBookmarked ? const Color(0xFFFF7F5C) : Colors.white70,
                ),
              ),
            ),
            const SizedBox(width: 15),
            // Start Reading Button
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageManga(manga: widget.manga),
                    ),
                  );
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8A71),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Start Reading",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
