import 'dart:async';

import 'package:to_do_bloc/model/todo.dart';
import 'package:to_do_bloc/repository/todo_repository.dart';

class ToDoBloc {
  final _repository = ToDoRepository();

  final _todoController = StreamController<List<ToDo>>.broadcast();

  get todos => _todoController.stream;

  ToDoBloc() {
    getToDosEvent();
  }

  getToDosEvent({String query}) async {
    //* sink is a way of adding data reactively to the stream by registering a new event
    _todoController.sink.add(await _repository.getAllToDos(query: query));
  }

  addToDo(ToDo todo) async {
    await _repository.insertToDo(todo);
    getToDosEvent();
  }

  updateToDo(ToDo todo) async {
    await _repository.updateToDo(todo);
    getToDosEvent();
  }

  deleteToDoById(int id) async {
    _repository.deleteToDoById(id);
    getToDosEvent();
  }

  dispose() {
    _todoController.close();
  }
}
