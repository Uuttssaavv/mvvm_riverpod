import 'package:flutter_project/models/db_product_db_model.dart';
import 'package:flutter_project/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    print(_database?.isOpen);
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

  Future<Product> create(Product product) async {
    final db = await instance.database;

    final id = await db.insert(tableName, product.toMap());
    return product.copyWith(id: id);
  }

  Future<Product> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: ProductDatabaseEntity.values,
      where: '${ProductDatabaseEntity.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Product>> readAllNotes() async {
    final db = await instance.database;

    const orderBy =
        '${ProductDatabaseEntity.dateAdded} ASC'; //this will order products by date added in ascending order

    final result = await db.query(tableName, orderBy: orderBy);

    return result.map((json) => Product.fromMap(json)).toList();
  }

  Future<int> update(Product product) async {
    final db = await instance.database;

    return db.update(
      tableName,
      product.toMap(),
      where: '${ProductDatabaseEntity.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableName,
      where: '${ProductDatabaseEntity.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
