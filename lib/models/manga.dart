class Manga {
  String title;
  String description;
  String authors;
  String rating;
  String favorites;
  String status;
  bool isBookmarked;
  String coverPage;
  String chapter;

  Manga({
    required this.title,
    required this.description,
    required this.authors,
    required this.rating,
    required this.favorites,
    required this.status,
    this.isBookmarked = false,
    required this.coverPage,
    required this.chapter,
  });
}
