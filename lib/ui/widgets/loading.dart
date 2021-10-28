import 'package:flutter/material.dart';
import 'package:to_do_bloc/bloc/todo_bloc.dart';

Widget loadingData(ToDoBloc todoBloc) {
  todoBloc.getToDosEvent();
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
          Text("Loading...",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}
