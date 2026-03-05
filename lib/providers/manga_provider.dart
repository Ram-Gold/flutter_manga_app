import 'package:flutter/material.dart';
import '../models/manga.dart';
import '../data/database_helper.dart';

// Notifies the UI to rebuild whenever manga data is added, updated, or deleted.
class MangaProvider with ChangeNotifier {
  List<Manga> _allManga = [];
  List<Manga> _bookmarkedManga = [];

  List<Manga> get allManga => _allManga;
  List<Manga> get bookmarkedManga => _bookmarkedManga;

  // Fetches fresh data from the database and updates the UI listeners.
  Future<void> fetchManga() async {
    _allManga = await DatabaseHelper.instance.getAllManga();
    _bookmarkedManga = await DatabaseHelper.instance.getBookmarkedManga();
    notifyListeners();
  }

  // Saves a new manga to the database and refreshes the local lists.
  Future<void> addManga(Manga manga) async {
    await DatabaseHelper.instance.insert(manga);
    await fetchManga();
  }

  // Updates manga details in the database and triggers a UI refresh.
  Future<void> updateManga(Manga manga) async {
    await DatabaseHelper.instance.update(manga);
    await fetchManga();
  }

  // Removes a manga from the database and refreshes the UI.
  Future<void> deleteManga(int id) async {
    await DatabaseHelper.instance.delete(id);
    await fetchManga();
  }

  // Switches the bookmark status of a manga and saves the change.
  Future<void> toggleBookmark(Manga manga) async {
    manga.isBookmarked = !manga.isBookmarked;
    await DatabaseHelper.instance.update(manga);
    await fetchManga();
  }
}
