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

  Future<ProductModel> create(ProductModel product) async {
    final db = await instance.database;

    final id = await db.insert(tableName, product.toMap());
    return product.copyWith(id: id);
  }

  Future<ProductList> getAllProducts() async {
    final db = await instance.database;

    const orderBy =
        '${ProductDatabaseEntity.dateAdded} ASC'; //this will order products by date added in ascending order

    final result = await db.query(tableName, orderBy: orderBy);

    return result.map((json) => ProductModel.fromMap(json)).toList();
  }

  Future<int> update(ProductModel product) async {
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
