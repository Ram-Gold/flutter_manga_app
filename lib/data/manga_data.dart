import '../models/manga.dart';

class MangaRepository {
  static final List<Manga> allManga = [
    Manga(
      title: "Umamusume Pretty Derby: Star Blossom",
      description: "The popular cross-media content \"Uma Musume Pretty Derby\" features \"Uma Musume\" who have inherited the names and souls of numerous racehorses! A new legend begins with the indomitable horse girl \"Sakura Laurel\" as the main character.",
      authors: "Monjūsaki , Cygames, Hotani Shin",
      rating: "8.99",
      favorites: "5,654",
      status: "Ongoing",
      isBookmarked: true,
      coverPage: "assets/images/Umamusume_Star_Blossom.jpg",
      chapter: "CH1_UMAMUSUME_STAR_BLOSSOM.pdf",
    ),
    Manga(
      title: "Shin Ootaka, Homare",
      description: "Description for Shin Ootaka, Homare.",
      authors: "Monjūsaki , Cygames, Hotani Shin",
      rating: "8.50",
      favorites: "1,234",
      status: "Planning",
      coverPage: "assets/images/Shin_Ootaka_Homare.jpg",
      chapter: "SHIN_OOTAKA.pdf",
    ),
    Manga(
      title: "Oshi no Ko",
      description: "Description for Oshi no Ko.",
      authors: "Akasaka Aka, Yokoyari Mengo",
      rating: "9.00",
      favorites: "10,000",
      status: "Ongoing",
      coverPage: "assets/images/Oshi no Ko.jpg",
      chapter: "OSHINOKO_CH1.pdf",
    ),
    Manga(
      title: "Uma Musume: Cinderella Gray",
      description: "Description for Cinderella Gray.",
      authors: "Sugiura Masafumi, Itou Junnousuke, Kuzumi Taiyou",
      rating: "8.80",
      favorites: "4,500",
      status: "Reading",
      coverPage: "assets/images/Umamusume_Cinderella_Gray.jpg",
      chapter: "CINDERELLA_GRAY_CH1.pdf",
    ),
    Manga(
      title: "Jujutsu Kaisen",
      description: "Description for JJK.",
      authors: "Gege Akutami",
      rating: "9.20",
      favorites: "25,000",
      status: "Completed",
      coverPage: "assets/images/JJK.jpg",
      chapter: "JJK_CH1.pdf",
    ),
    Manga(
      title: "DanDaDan",
      description: "Description for DanDaDan.",
      authors: "Yukinobu Tatsu",
      rating: "8.70",
      favorites: "8,000",
      status: "Ongoing",
      coverPage: "assets/images/Dandadan.jpg",
      chapter: "DANDADAN_CH1.pdf",
    ),
    Manga(
      title: "One Piece",
      description: "Description for One Piece.",
      authors: "Eiichiro Oda",
      rating: "9.99",
      favorites: "100,000",
      status: "Ongoing",
      coverPage: "assets/images/One_Piece.jpg",
      chapter: "ONE_PIECE_CH1.pdf",
    ),
  ];

  static List<Manga> getBookmarkedManga() {
    return allManga.where((manga) => manga.isBookmarked).toList();
  }

  static List<Manga> searchManga(String query) {
    if (query.isEmpty) return [];
    return allManga
        .where((manga) =>
            manga.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
