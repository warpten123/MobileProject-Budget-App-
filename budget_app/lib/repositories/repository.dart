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

  readItemsByCategoryId(items, categoryID) async {
    var connection = await database;
    return await connection
        .query(items, where: 'category_id=?', whereArgs: [categoryID]);
  }

  readCategoryTotal(categoryID) async {
    var connection = await database;
    return await connection.rawQuery(
        "SELECT SUM(item_value) FROM items WHERE category_id = $categoryID");
  }

  updateCategoryTotal(categoryID) async {
    var connection = await database;
    return await connection.execute(
        "UPDATE categories SET category_total = (SELECT SUM(item_value) FROM items WHERE item_id = categories.category_id) WHERE EXISTS (SELECT SUM(item_value) FROM items WHERE item_id = categories.category_id) AND categories.category_id = $categoryID");
    //"UPDATE categories c INNER JOIN (SELECT category_id, SUM(item_value) AS category_total FROM items GROUP BY cateogory_id) i ON c.category_id = i.category_id SET c.category_total = i.category_total;"
  }

  updateItem(itemData) async {
    var connection = await database;
    return await connection.update("items", itemData,
        where: "item_id = ?", whereArgs: [itemData['item_id']]);
  }

  deleteItem(itemData) async {
    var connection = await database;
    return await connection
        .delete("items", where: "item_id=?", whereArgs: [itemData["item_id"]]);
  }
}
