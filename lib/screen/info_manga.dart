import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/manga.dart';
import '../providers/manga_provider.dart';
import '../providers/theme_provider.dart';
import 'page_manga.dart';
import 'add_edit_manga.dart';

class InfoManga extends StatefulWidget {
  final Manga manga;

  const InfoManga({super.key, required this.manga});

  @override
  State<InfoManga> createState() => _InfoMangaState();
}

class _InfoMangaState extends State<InfoManga> {
  void _deleteManga() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Manga", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
          content: Text("Are you sure you want to delete this manga?", style: GoogleFonts.karla()),
          actions: [
            TextButton(
              child: Text("Cancel", style: GoogleFonts.karla(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Delete", style: GoogleFonts.karla(color: Colors.red)),
              onPressed: () {
                Provider.of<MangaProvider>(context, listen: false).deleteManga(widget.manga.id!);
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mangaProvider = Provider.of<MangaProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeColors = Theme.of(context).extension<MangaThemeColors>()!;
    
    // Find the latest manga data from provider in case it was edited
    Manga currentManga;
    try {
      currentManga = mangaProvider.allManga.firstWhere(
        (m) => m.id == widget.manga.id
      );
    } catch (e) {
      // If manga was deleted, just use the passed one for the final frame before pop
      currentManga = widget.manga;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: themeColors.headingTitle),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: themeColors.headingTitle),
                        onPressed: () => themeProvider.toggleTheme(),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: themeColors.headingTitle),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditMangaScreen(manga: currentManga),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: _deleteManga,
                      ),
                    ],
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
                      child: currentManga.coverPage.startsWith('assets/')
                        ? Image.asset(currentManga.coverPage, height: 320, width: 220, fit: BoxFit.cover)
                        : Image.file(File(currentManga.coverPage), height: 320, width: 220, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      currentManga.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: themeColors.headingTitle,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Authors
                    Text(
                      currentManga.authors,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.karla(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: themeColors.searchBarPlaceholder,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Genres
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: currentManga.genres.map((genre) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: themeColors.genrePillBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Text(
                          genre,
                          style: GoogleFonts.montserrat(
                            color: themeColors.genrePillText, 
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Rating and Favorites Box
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: themeColors.searchBarBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star_border, color: Color(0xFFFF7F5C)),
                              const SizedBox(width: 8),
                              Text(
                                currentManga.rating,
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFFFF7F5C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white24,
                          ),
                          Row(
                            children: [
                              Icon(Icons.bookmark_outline, color: themeColors.headingTitle!.withOpacity(0.7)),
                              const SizedBox(width: 8),
                              Text(
                                currentManga.favorites,
                                style: GoogleFonts.montserrat(
                                  color: themeColors.headingTitle,
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

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: themeColors.headingTitle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      currentManga.description,
                      style: GoogleFonts.karla(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: themeColors.headingTitle!.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                await mangaProvider.toggleBookmark(currentManga);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: themeColors.searchBarBg,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  currentManga.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: currentManga.isBookmarked ? const Color(0xFFFF7F5C) : themeColors.headingTitle!.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageManga(manga: currentManga),
                    ),
                  );
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8A71),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Start Reading",
                      style: GoogleFonts.montserrat(
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
