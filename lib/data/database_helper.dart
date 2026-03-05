import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/manga.dart';

// Manages the SQLite database connection and provides methods for database operations.
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Returns the existing database or initializes a new one if it doesn't exist.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('manga.db');
    return _database!;
  }

  // Locates the database file on the device and opens the connection.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 10,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  // Handles database schema updates when the version number changes.
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 10) {
      await db.execute('DROP TABLE IF EXISTS manga');
      await _createDB(db, newVersion);
    }
  }

  // Defines the manga table structure and populates it with initial sample data.
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
        coverPage: "assets/images/umamusume_star_blossom.jpg",
        chapter: "assets/chapters/ch1_umamusume_star_blossom.jpeg",
        genres: ["Action", "Sports", "Drama"],
      ),
       Manga(
        title: "Idolatry",
        description: "High school girl Junna Harumi's purpose in life is to support the idol Fuwari Tsukishiro! One day, the idol group Fuwari belongs to disbands. In her despair, Junna learns that Fuwari will be trying out for an idol audition program. There will be a total of 100 participants - in order to lead her idol to the top, Junna decides to take part in the audition herself and work behind the scenes. (Source: MangaUpdates, edited)",
        authors: "Monjūsaki , Cygames, Hotani Shin",
        rating: "8.50",
        favorites: "1,234",
        status: "Hiatus",
        coverPage: "assets/images/idolatry.jpg",
        chapter: "assets/chapters/ch1_idolatry.png",
        genres: ["Drama", "Slice of Life"],
      ),
      Manga(
        title: "Oshi no Ko",
        description: "The story begins with a beautiful girl, her perfectly fake smile, and the people who love her selfishly for it. What transpires behind the scenes of the glittering showbiz industry? How far would you go for the sake of your beloved idol? What would you do if you found out reincarnation was real? The star of the show is Aquamarine Hoshino and the stage is but a mere facade. Will he manage to reach the climax before the world of glamour swallows him whole?",
        authors: "Akasaka Aka, Yokoyari Mengo",
        rating: "9.00",
        favorites: "10,000",
        status: "Ongoing",
        coverPage: "assets/images/oshi_no_ko.jpg",
        chapter: "assets/chapters/ch1_oshi_no_ko.pdf",
        genres: ["Drama", "Mystery", "Supernatural"],
      ),
      Manga(
        title: "Uma Musume: Cinderella Gray",
        description: "Uma Musume: Cinderella Gray is a spin-off title of the Uma Musume project by Cygames. It follows Oguri Cap through her time at Kasamatsu Training Center Academy and on her journey of becoming a legendary horse girl.",
        authors: "Sugiura Masafumi, Itou Junnousuke, Kuzumi Taiyou",
        rating: "8.80",
        favorites: "4,500",
        status: "Ongoing",
        coverPage: "assets/images/umamusume_cinderella_gray.jpg",
        chapter: "assets/chapters/ch1_umamusume_cinderella_gray.jpeg",
        genres: ["Action", "Sports"],
      ),
      Manga(
        title: "Jujutsu Kaisen",
        description: "For some strange reason, Itadori Yuuji, despite his insane athleticism, would rather just hang out with the Occult Club. However, he soon finds out that the occult is as real as it gets when his fellow club members are attacked! Meanwhile, the mysterious Fushiguro Megumi is tracking down a special-grade cursed object, and his search leads him to Itadori…",
        authors: "Gege Akutami",
        rating: "9.20",
        favorites: "25,000",
        status: "Completed",
        coverPage: "assets/images/jjk.jpg",
        chapter: "assets/chapters/ch1_jjk.pdf",
        genres: ["Action", "Supernatural", "Thriller"],
      ),
      Manga(
        title: "DanDaDan",
        description: "After being aggressively rejected, Momo Ayase finds herself sulking when she stumbles across a boy being bullied. Saved by her rash kindness, the occult-obsessed boy attempts to speak to her about supernatural interests he believes they share. Rejecting his claims, Ayase proclaimed that she is instead a believer in ghosts, starting an argument between the two over which is real. In a bet to determine who's correct, the two decide to separately visit locations associated with both the occult and the supernatural—Ayase visiting the former and the boy visiting the latter. When the two reach their respective places, it turns out that neither of them was wrong and that both the occult and ghosts do exist. This marks the beginning of Ayase and the boy's adventure, who shares a name with Ayase's favorite idol—Ken Takakura, as they attempt to fix the surreal supernatural and sci-fi elements around them to return to a normal life..",
        authors: "Yukinobu Tatsu",
        rating: "8.70",
        favorites: "8,000",
        status: "Ongoing",
        coverPage: "assets/images/dandadan.jpg",
        chapter: "assets/chapters/ch1_dandadan.pdf",
        genres: ["Action", "Comedy", "Sci-Fi", "Supernatural"],
      ),
      Manga(
        title: "One Piece",
        description: """Gol D. Roger, a man referred to as the "Pirate King," is set to be executed by the World Government. But just before his demise, he confirms the existence of a great treasure, One Piece, located somewhere within the vast ocean known as the Grand Line. Announcing that One Piece can be claimed by anyone worthy enough to reach it, the Pirate King is executed and the Great Age of Pirates begins. Twenty-two years later, a young man by the name of Monkey D. Luffy is ready to embark on his own adventure, searching for One Piece and striving to become the new Pirate King. Armed with just a straw hat, a small boat, and an elastic body, he sets out on a fantastic journey to gather his own crew and a worthy ship that will take them across the Grand Line to claim the greatest status on the high seas.""",
        authors: "Eiichiro Oda",
        rating: "9.99",
        favorites: "100,000",
        status: "Ongoing",
        coverPage: "assets/images/one_piece.jpg",
        chapter: "assets/chapters/ch1_one_piece.pdf",
        genres: ["Action", "Adventure", "Comedy", "Fantasy"],
      ),
    ];

    for (var manga in initialManga) {
      await db.insert('manga', manga.toMap());
    }
  }

  // Inserts a new manga record into the database table.
  Future<int> insert(Manga manga) async {
    final db = await instance.database;
    return await db.insert('manga', manga.toMap());
  }

  // Retrieves all manga entries stored in the database.
  Future<List<Manga>> getAllManga() async {
    final db = await instance.database;
    final result = await db.query('manga');
    return result.map((json) => Manga.fromMap(json)).toList();
  }

  // Retrieves only the manga records that are marked as bookmarked.
  Future<List<Manga>> getBookmarkedManga() async {
    final db = await instance.database;
    final result = await db.query('manga', where: 'isBookmarked = ?', whereArgs: [1]);
    return result.map((json) => Manga.fromMap(json)).toList();
  }

  // Searches the database for manga titles that match the search query.
  Future<List<Manga>> searchManga(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'manga',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((json) => Manga.fromMap(json)).toList();
  }

  // Updates an existing manga record in the database.
  Future<int> update(Manga manga) async {
    final db = await instance.database;
    return await db.update(
      'manga',
      manga.toMap(),
      where: 'id = ?',
      whereArgs: [manga.id],
    );
  }

  // Deletes a specific manga entry from the database by its ID.
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'manga',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
