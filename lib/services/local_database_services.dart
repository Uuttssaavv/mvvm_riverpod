import 'package:flutter_project/models/db_product_db_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableName ( 
  ${ProductDatabaseEntity.id} $idType, 
  ${ProductDatabaseEntity.title} $textType,
  ${ProductDatabaseEntity.description} $textType,
  ${ProductDatabaseEntity.dateAdded} $textType
  )
''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
