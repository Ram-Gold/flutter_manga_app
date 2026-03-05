import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/manga_provider.dart';
import '../providers/theme_provider.dart';
import 'info_manga.dart';
import 'main_wrapper.dart';
import 'add_edit_manga.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeColors = Theme.of(context).extension<MangaThemeColors>()!;
    
    var mangaList = mangaProvider.allManga;

    if (_selectedGenre != 'All') {
      mangaList = mangaList.where((m) => m.genres.contains(_selectedGenre)).toList();
    }

    final recentlyAdded = mangaList.reversed.toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Browse',
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: themeColors.headingTitle,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                        onPressed: () => themeProvider.toggleTheme(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const AddEditMangaScreen())
                        ),
                      ),
                    ],
                  ),
                ],
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
                    color: themeColors.searchBarBg,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(Icons.search, color: themeColors.searchIcon),
                      ),
                      Text(
                        'Search Manga',
                        style: GoogleFonts.karla(
                          color: themeColors.searchBarPlaceholder,
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
                  color: themeColors.headingTitle,
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    'All', 'Action', 'Romance', 'Sci-Fi', 'Mystery', 
                    'Thriller', 'Supernatural', 'Comedy', 'Music', 'Sports', 'Drama', 'Slice of Life', 'Adventure', 'Fantasy'
                  ].map((genre) => _buildCustomChip(genre, themeColors)).toList(),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                "Recommended for You",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: themeColors.headingTitle,
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
                      return _buildMangaItem(context, mangaList[index], themeColors);
                    },
                  ),
                ),

              const SizedBox(height: 30),

              Text(
                "Recently Added",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: themeColors.headingTitle,
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
                      return _buildMangaItem(context, recentlyAdded[index], themeColors);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomChip(String label, MangaThemeColors colors) {
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
          color: isSelected ? const Color(0xFFFF8A71) : colors.genrePillBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : colors.genrePillText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMangaItem(BuildContext context, dynamic manga, MangaThemeColors colors) {
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
              child: manga.coverPage.startsWith('assets/') 
                ? Image.asset(manga.coverPage, height: 240, width: 160, fit: BoxFit.cover)
                : Image.file(File(manga.coverPage), height: 240, width: 160, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Text(
              manga.title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold, 
                color: colors.headingTitle
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              manga.authors,
              style: GoogleFonts.karla(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: colors.searchBarPlaceholder
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
