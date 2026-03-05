import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/manga_provider.dart';
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
    var bookmarkedManga = mangaProvider.bookmarkedManga;

    if (_selectedStatus != 'All') {
      bookmarkedManga = bookmarkedManga.where((m) => m.status == _selectedStatus).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Library',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Status Chips
              const Text(
                'Status',
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
                    _buildCustomChip('All'),
                    _buildCustomChip('Ongoing'),
                    _buildCustomChip('Hiatus'),
                    _buildCustomChip('Completed'),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              if (bookmarkedManga.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Icon(Icons.bookmark_border, size: 64, color: Colors.grey.withOpacity(0.3)),
                        const SizedBox(height: 16),
                        Text(
                          _selectedStatus == 'All' 
                            ? 'Your library is empty' 
                            : 'No $_selectedStatus manga found', 
                          style: const TextStyle(color: Colors.grey, fontSize: 16)
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
                    return _buildMangaGridItem(context, manga);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomChip(String label) {
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
          color: isSelected ? const Color(0xFF323240) : const Color(0xFF1C1C2A),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.orangeAccent.withOpacity(0.3)) : null,
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
      ),
    );
  }

  Widget _buildMangaGridItem(BuildContext context, dynamic manga) {
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
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                manga.coverPage,
                fit: BoxFit.cover,
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
  }
}
