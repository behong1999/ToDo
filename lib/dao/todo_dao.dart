import 'package:to_do_bloc/database/database.dart';
import 'package:to_do_bloc/model/todo.dart';

//* Data Access Object
//* Used to manage all local Database CRUD operations for ToDo model asynchronously
//! Comminucator between the ToDoRepository and DatabaseProvider
class ToDoDao {
  //final dbProvider = DatabaseProvider.dbProvider;
  final DatabaseProvider dbProvider = DatabaseProvider();
  //Adds new ToDo records
  Future<int> createToDo(ToDo todo) async {
    final db = await dbProvider.database;
    var result = db.insert(ToDoTABLE, todo.toDatabaseJson());

    return result;
  }

  //Get All ToDo items
  //Searches if query string was passed
  Future<List<ToDo>> getToDos({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(
          ToDoTABLE,
          columns: columns,
          where: "description LIKE ?",
          whereArgs: ['%$query%'],
        );
    } else {
      result = await db.query(ToDoTABLE, columns: columns);
    }

    List<ToDo> todos = result.isNotEmpty
        ? result.map((item) => ToDo.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  //Update ToDo record
  Future<int> updateToDo(ToDo todo) async {
    final db = await dbProvider.database;

    var result = await db.update(ToDoTABLE, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  //Delete ToDo records
  Future<int> deleteToDo(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(
      ToDoTABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future deleteAllToDos() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      ToDoTABLE,
    );
    return result;
  }
}
