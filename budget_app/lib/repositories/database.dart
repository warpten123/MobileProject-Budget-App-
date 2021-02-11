import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'budget_app_database.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _onDatabaseCreate);
    return database;
  }

  _onDatabaseCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE category(category_id INTEGER PRIMARY KEY, category_title TEXT, category_total NUMERIC, category_limit NUMERIC);");

    await database.execute(
        "CREATE TABLE item(item_id INTEGER PRIMARY KEY, category_id INTEGER, FOREIGN KEY(category_id) REFERENCES category(category_id), item_title TEXT, item_value NUMERIC, item_date INTEGER);");
  }
}
