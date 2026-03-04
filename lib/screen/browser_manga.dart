import 'package:flutter/material.dart';
import '../models/manga.dart';
import '../data/database_helper.dart';
import 'info_manga.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  late Future<List<Manga>> _mangaFuture;

  @override
  void initState() {
    super.initState();
    _mangaFuture = DatabaseHelper.instance.getAllManga();
  }

  void _refreshManga() {
    setState(() {
      _mangaFuture = DatabaseHelper.instance.getAllManga();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: FutureBuilder<List<Manga>>(
          future: _mangaFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No manga found', style: TextStyle(color: Colors.white)));
            }

            final mangaList = snapshot.data!;
            final recentlyAdded = mangaList.reversed.toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Browse',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar UI (Visual Only, navigates to Search Tab)
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C2A),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(Icons.search, color: Color(0xFFA6A6BB)),
                        ),
                        Text(
                          'Search Manga',
                          style: TextStyle(color: Color(0xFFA6A6BB), fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Genre',
                    style: TextStyle(
                      fontSize: 22,
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
                      itemCount: mangaList.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return _buildMangaItem(mangaList[index]);
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

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
                      itemCount: recentlyAdded.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return _buildMangaItem(recentlyAdded[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCustomChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFFA6A6BB),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMangaItem(Manga manga) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoManga(manga: manga),
          ),
        );
        _refreshManga();
      },
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                manga.coverPage,
                height: 180,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              manga.title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              manga.authors,
              style: const TextStyle(color: Color(0xFFA6A6BB)),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
