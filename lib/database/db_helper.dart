import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const tableName = 'Barcode';
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'barcode.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      content TEXT,
      scanTime TEXT
    )
  ''');
  }


  static Future<List<Map<String, dynamic>>?> getBarcodes() async {
    return await _db?.query(tableName);
  }

  static Future<Map<String, dynamic>?> getBarcodeById(int id) async {
    final result = await _db?.query(tableName, where: 'id = ?', whereArgs: [id]);

    if (result!.isNotEmpty) return result.first;

    return null;
  }

  static Future<int?> addBarcode(Map<String, dynamic> Barcode) async {
    return await _db?.insert(tableName, Barcode);
  }

  static Future<void> deleteBarcode(int id) async {
    await _db?.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
  
}
