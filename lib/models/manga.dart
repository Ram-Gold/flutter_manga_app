class Manga {
  int? id;
  String title;
  String description;
  String authors;
  String rating;
  String favorites;
  String status;
  bool isBookmarked;
  String coverPage;
  String chapter;
  List<String> genres;

  Manga({
    this.id,
    required this.title,
    required this.description,
    required this.authors,
    required this.rating,
    required this.favorites,
    required this.status,
    this.isBookmarked = false,
    required this.coverPage,
    required this.chapter,
    required this.genres,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authors': authors,
      'rating': rating,
      'favorites': favorites,
      'status': status,
      'isBookmarked': isBookmarked ? 1 : 0,
      'coverPage': coverPage,
      'chapter': chapter,
      'genres': genres.join(','),
    };
  }

  factory Manga.fromMap(Map<String, dynamic> map) {
    return Manga(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      authors: map['authors'],
      rating: map['rating'],
      favorites: map['favorites'],
      status: map['status'],
      isBookmarked: map['isBookmarked'] == 1,
      coverPage: map['coverPage'],
      chapter: map['chapter'],
      genres: map['genres'].toString().split(','),
    );
  }
}
