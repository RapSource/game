import 'package:gameku/model/data/game_detail.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/rawgame.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tblFavorite(
            id INT PRIMARY KEY,
            name TEXT,
            background_image TEXT,
            genres TEXT,
            rating DOUBLE
          )
          '''
        );
      },
      version: 1
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertFavorite(GameDetail game) async {
    final db = await database;
    await db!.insert(_tblFavorite, game.toJson());
  }

  Future<List<GameDetail>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((res) => GameDetail.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(int id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(int id) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}