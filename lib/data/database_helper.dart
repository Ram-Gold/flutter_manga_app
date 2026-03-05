import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/manga.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('manga.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE manga (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        authors TEXT NOT NULL,
        rating TEXT NOT NULL,
        favorites TEXT NOT NULL,
        status TEXT NOT NULL,
        isBookmarked INTEGER NOT NULL,
        coverPage TEXT NOT NULL,
        chapter TEXT NOT NULL,
        genres TEXT NOT NULL
      )
    ''');

    // Initial Data
    final initialManga = [
      Manga(
        title: "Umamusume Pretty Derby: Star Blossom",
        description: "The popular cross-media content Uma Musume Pretty Derby features Uma Musume who have inherited the names and souls of numerous racehorses! A new legend begins with the indomitable horse girl Sakura Laurel as the main character.",
        authors: "Monjūsaki , Cygames, Hotani Shin",
        rating: "8.99",
        favorites: "5,654",
        status: "Ongoing",
        isBookmarked: true,
        coverPage: "assets/images/Umamusume_Star_Blossom.jpg",
        chapter: "CH1_UMAMUSUME_STAR_BLOSSOM.pdf",
        genres: ["Action", "Sports", "Drama"],
      ),
       Manga(
        title: "Idolatry",
        description: "High school girl Junna Harumi's purpose in life is to support the idol Fuwari Tsukishiro! One day, the idol group Fuwari belongs to disbands. In her despair, Junna learns that Fuwari will be trying out for an idol audition program. There will be a total of 100 participants - in order to lead her idol to the top, Junna decides to take part in the audition herself and work behind the scenes. (Source: MangaUpdates, edited)",
        authors: "Monjūsaki , Cygames, Hotani Shin",
        rating: "8.50",
        favorites: "1,234",
        status: "Hiatus",
        coverPage: "assets/images/Idolatry.jpg",
        chapter: "SHIN_OOTAKA.pdf",
        genres: ["Drama", "Slice of Life"],
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
        genres: ["Drama", "Mystery", "Supernatural"],
      ),
      Manga(
        title: "Uma Musume: Cinderella Gray",
        description: "Description for Cinderella Gray.",
        authors: "Sugiura Masafumi, Itou Junnousuke, Kuzumi Taiyou",
        rating: "8.80",
        favorites: "4,500",
        status: "Ongoing",
        coverPage: "assets/images/Umamusume_Cinderella_Gray.jpg",
        chapter: "CINDERELLA_GRAY_CH1.pdf",
        genres: ["Action", "Sports"],
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
        genres: ["Action", "Supernatural", "Thriller"],
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
        genres: ["Action", "Comedy", "Sci-Fi", "Supernatural"],
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
        genres: ["Action", "Adventure", "Comedy", "Fantasy"],
      ),
    ];

    for (var manga in initialManga) {
      await db.insert('manga', manga.toMap());
    }
  }

  Future<int> insert(Manga manga) async {
    final db = await instance.database;
    return await db.insert('manga', manga.toMap());
  }

  Future<List<Manga>> getAllManga() async {
    final db = await instance.database;
    final result = await db.query('manga');
    return result.map((json) => Manga.fromMap(json)).toList();
  }

  Future<List<Manga>> getBookmarkedManga() async {
    final db = await instance.database;
    final result = await db.query('manga', where: 'isBookmarked = ?', whereArgs: [1]);
    return result.map((json) => Manga.fromMap(json)).toList();
  }

  Future<List<Manga>> searchManga(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'manga',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((json) => Manga.fromMap(json)).toList();
  }

  Future<int> update(Manga manga) async {
    final db = await instance.database;
    return await db.update(
      'manga',
      manga.toMap(),
      where: 'id = ?',
      whereArgs: [manga.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'manga',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
