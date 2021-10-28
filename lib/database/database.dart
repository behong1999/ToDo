import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const ToDoTABLE = 'Todo';

//* Used to manage creating the database schema
class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $ToDoTABLE ("
        "id INTEGER PRIMARY KEY, "
        "description TEXT, "
        "is_completed INTEGER "
        ")");
  }

  //? OPTIONAL
  //* Used only for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Todo.db");
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      // onUpgrade: onUpgrade,
    );
    return database;
  }

  get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }
}
