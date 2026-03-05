import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/manga.dart';
import '../data/database_helper.dart';
import 'info_manga.dart';

class SearchManga extends StatefulWidget {
  const SearchManga({super.key});

  @override
  State<SearchManga> createState() => _SearchMangaState();
}

class _SearchMangaState extends State<SearchManga> {
  String _query = '';
  List<Manga> _searchResults = [];

  void _onSearchChanged(String query) async {
    final results = await DatabaseHelper.instance.searchManga(query);
    setState(() {
      _query = query;
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C2A),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: _onSearchChanged,
                      autofocus: true,
                      style: GoogleFonts.karla(color: Colors.white, fontSize: 16),
                      cursorColor: const Color(0xFFFF8A71),
                      decoration: InputDecoration(
                        hintText: 'Search Manga',
                        hintStyle: GoogleFonts.karla(color: const Color(0xFFA6A6BB), fontSize: 16),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 16, right: 12),
                          child: Icon(Icons.search, color: Color(0xFFA6A6BB)),
                        ),
                        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Column(
                  children: [
                    if (_query.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "Start typing to search manga...",
                            style: GoogleFonts.karla(color: const Color(0xFFA6A6BB), fontSize: 16),
                          ),
                        ),
                      )
                    else if (_searchResults.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "No manga found.",
                            style: GoogleFonts.karla(color: const Color(0xFFA6A6BB), fontSize: 16),
                          ),
                        ),
                      )
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _searchResults.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.52,
                        ),
                        itemBuilder: (context, index) {
                          final manga = _searchResults[index];
                          return _buildMangaGridItem(context, manga);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMangaGridItem(BuildContext context, Manga manga) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoManga(manga: manga),
          ),
        );
        _onSearchChanged(_query); // Refresh results
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                manga.coverPage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            manga.title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            manga.authors,
            style: GoogleFonts.karla(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: const Color(0xFFA6A6BB),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
