import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item_model.dart';

class ItemLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'items.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER,
        companyID INTEGER,
        categoryID INTEGER,
        itemCode TEXT,
        name TEXT,
        price REAL,
        taxPercent INTEGER,
        discountPercent INTEGER,
        barcode TEXT
      )
    ''');
  }

  Future<void> insertItems(List<ItemModel> items) async {
    final db = await database;

    await db.delete('items');

    for (var item in items) {
      await db.insert(
        'items',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<ItemModel>> getItems() async {
    final db = await database;
    final maps = await db.query('items');

    return maps.map((map) => ItemModel.fromJson(map)).toList();
  }
}
