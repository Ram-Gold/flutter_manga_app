import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/manga_provider.dart';
import 'info_manga.dart';
import 'main_wrapper.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  String _selectedGenre = 'All';

  @override
  Widget build(BuildContext context) {
    final mangaProvider = Provider.of<MangaProvider>(context);
    var mangaList = mangaProvider.allManga;

    if (_selectedGenre != 'All') {
      mangaList = mangaList.where((m) => m.genres.contains(_selectedGenre)).toList();
    }

    final recentlyAdded = mangaList.reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Browse',
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Search Bar UI
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainWrapper(initialIndex: 2),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C2A),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(Icons.search, color: Color(0xFFA6A6BB)),
                      ),
                      Text(
                        'Search Manga',
                        style: GoogleFonts.karla(
                          color: const Color(0xFFA6A6BB),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                'Genre',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
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
                    'All', 'Action', 'Romance', 'Sci-Fi', 'Mystery', 
                    'Thriller', 'Supernatural', 'Comedy', 'Music'
                  ].map((genre) => _buildCustomChip(genre)).toList(),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                "Recommended for You",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              if (mangaList.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'No manga found for this genre.',
                      style: GoogleFonts.karla(color: Colors.grey),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 320,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mangaList.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _buildMangaItem(context, mangaList[index]);
                    },
                  ),
                ),

              const SizedBox(height: 30),

              Text(
                "Recently Added",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              if (recentlyAdded.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'No recently added manga for this genre.',
                      style: GoogleFonts.karla(color: Colors.grey),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 320,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentlyAdded.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _buildMangaItem(context, recentlyAdded[index]);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomChip(String label) {
    bool isSelected = _selectedGenre == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGenre = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF323240) : const Color(0xFF1C1C2A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFFA6A6BB),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMangaItem(BuildContext context, dynamic manga) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoManga(manga: manga),
          ),
        );
      },
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                manga.coverPage,
                height: 240,
                width: 160,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              manga.title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold, 
                color: Colors.white
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              manga.authors,
              style: GoogleFonts.karla(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: const Color(0xFFA6A6BB)
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
