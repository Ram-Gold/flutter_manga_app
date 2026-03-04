import 'package:flutter/material.dart';
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                child: TextField(
                  onChanged: _onSearchChanged,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search Manga',
                    hintStyle: TextStyle(color: Color(0xFFA6A6BB)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFA6A6BB)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              if (_query.isEmpty)
                const Center(
                  child: Text(
                    "Start typing to search manga...",
                    style: TextStyle(color: Color(0xFFA6A6BB)),
                  ),
                )
              else if (_searchResults.isEmpty)
                const Center(
                  child: Text(
                    "No manga found.",
                    style: TextStyle(color: Color(0xFFA6A6BB)),
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
                    childAspectRatio: 0.50,
                  ),
                  itemBuilder: (context, index) {
                    final manga = _searchResults[index];
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
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFF1C1C2A),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  manga.coverPage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            manga.title,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
