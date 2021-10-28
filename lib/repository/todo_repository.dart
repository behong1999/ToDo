import 'package:to_do_bloc/dao/todo_dao.dart';
import 'package:to_do_bloc/model/todo.dart';

class ToDoRepository {
  final todoDao = ToDoDao();

  Future getAllToDos({String query}) => todoDao.getToDos(query: query);

  Future insertToDo(ToDo todo) => todoDao.createToDo(todo);

  Future updateToDo(ToDo todo) => todoDao.updateToDo(todo);

  Future deleteToDoById(int id) => todoDao.deleteToDo(id);

  Future deleteAllToDos() => todoDao.deleteAllToDos();
}
