import 'package:budget_app/repositories/database.dart';
import "package:sqflite/sqflite.dart";

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readItemsByCategoryId(items, categoryId) async {
    var connection = await database;
    return await connection
        .query(items, where: 'category_id=?', whereArgs: [categoryId]);
  }
}