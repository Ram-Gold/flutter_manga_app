import 'package:flutter/material.dart';
import '../models/manga.dart';

class PageManga extends StatelessWidget {
  final Manga manga;

  const PageManga({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(manga.title),
        backgroundColor: const Color(0xFF0F0F1A),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              "Reading: ${manga.chapter}",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              "(PDF Viewer Placeholder)",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
