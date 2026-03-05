import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/manga_provider.dart';
import '../providers/theme_provider.dart';
import 'info_manga.dart';

class LibraryManga extends StatefulWidget {
  const LibraryManga({super.key});

  @override
  State<LibraryManga> createState() => _LibraryMangaState();
}

class _LibraryMangaState extends State<LibraryManga> {
  String _selectedStatus = 'All';

  @override
  Widget build(BuildContext context) {
    final mangaProvider = Provider.of<MangaProvider>(context);
    final themeColors = Theme.of(context).extension<MangaThemeColors>()!;
    
    var bookmarkedManga = mangaProvider.bookmarkedManga;

    if (_selectedStatus != 'All') {
      bookmarkedManga = bookmarkedManga.where((m) => m.status == _selectedStatus).toList();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Library',
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: themeColors.headingTitle,
                ),
              ),
              const SizedBox(height: 24),

              // Status Chips
              Text(
                'Status',
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
                    'All', 'Ongoing', 'Hiatus', 'Completed'
                  ].map((status) => _buildCustomChip(status, themeColors)).toList(),
                ),
              ),
              const SizedBox(height: 30),

              if (bookmarkedManga.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Icon(Icons.bookmark_border, size: 64, color: themeColors.searchBarPlaceholder!.withOpacity(0.3)),
                        const SizedBox(height: 16),
                        Text(
                          _selectedStatus == 'All' 
                            ? 'Your library is empty' 
                            : 'No $_selectedStatus manga found', 
                          style: GoogleFonts.karla(color: themeColors.searchBarPlaceholder, fontSize: 16)
                        ),
                      ],
                    ),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bookmarkedManga.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.52,
                  ),
                  itemBuilder: (context, index) {
                    final manga = bookmarkedManga[index];
                    return _buildMangaGridItem(context, manga, themeColors);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomChip(String label, MangaThemeColors colors) {
    bool isSelected = _selectedStatus == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = label;
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

  Widget _buildMangaGridItem(BuildContext context, dynamic manga, MangaThemeColors colors) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoManga(manga: manga),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: manga.coverPage.startsWith('assets/')
                ? Image.asset(manga.coverPage, fit: BoxFit.cover)
                : Image.file(File(manga.coverPage), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            manga.title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors.headingTitle,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            manga.authors,
            style: GoogleFonts.karla(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: colors.searchBarPlaceholder,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
