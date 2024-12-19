import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/sawal_model.dart';

class LocalDB {
  static final LocalDB instance = LocalDB._init();
  static Database? _database;

  LocalDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sawal.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const sql = '''
    CREATE TABLE sawal (
      id TEXT PRIMARY KEY,
      content TEXT NOT NULL,
      category TEXT NOT NULL,
      date TEXT NOT NULL
    )
    ''';
    await db.execute(sql);
  }

  Future<void> insertSawal(SawalModel sawal) async {
    final db = await instance.database;
    await db.insert('sawal', sawal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SawalModel>> fetchAllSawals() async {
    final db = await instance.database;
    final result = await db.query('sawal');

    return result.map((json) => SawalModel.fromJson(json)).toList();
  }
}
