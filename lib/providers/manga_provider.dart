import 'package:flutter/material.dart';
import '../models/manga.dart';
import '../data/database_helper.dart';

class MangaProvider with ChangeNotifier {
  List<Manga> _allManga = [];
  List<Manga> _bookmarkedManga = [];

  List<Manga> get allManga => _allManga;
  List<Manga> get bookmarkedManga => _bookmarkedManga;

  Future<void> fetchManga() async {
    _allManga = await DatabaseHelper.instance.getAllManga();
    _bookmarkedManga = await DatabaseHelper.instance.getBookmarkedManga();
    notifyListeners();
  }

  Future<void> toggleBookmark(Manga manga) async {
    manga.isBookmarked = !manga.isBookmarked;
    await DatabaseHelper.instance.update(manga);
    await fetchManga(); // Refresh both lists
  }
}
