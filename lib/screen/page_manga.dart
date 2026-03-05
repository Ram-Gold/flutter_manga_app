import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import '../models/manga.dart';

class PageManga extends StatelessWidget {
  final Manga manga;

  const PageManga({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    final isAsset = manga.chapter.startsWith('assets/');
    final isPdf = manga.chapter.toLowerCase().endsWith('.pdf');

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(manga.title),
        backgroundColor: const Color(0xFF0F0F1A),
      ),
      body: isPdf
          ? (isAsset
              ? PdfViewer.asset(manga.chapter)
              : PdfViewer.file(manga.chapter))
          : SingleChildScrollView(
              child: isAsset
                  ? Image.asset(
                      manga.chapter,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    )
                  : Image.file(
                      File(manga.chapter),
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
            ),
    );
  }
}
