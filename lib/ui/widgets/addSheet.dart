import 'package:flutter/material.dart';
import 'package:to_do_bloc/bloc/todo_bloc.dart';
import 'package:to_do_bloc/model/todo.dart';

void showAddToDoSheet(BuildContext context, ToDoBloc todoBloc) {
  final _formKey = GlobalKey<FormState>();
  final _todoDescriptionFormController = TextEditingController();
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            color: Colors.transparent,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 20.0, right: 15, bottom: 20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescriptionFormController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'No description';
                                } else
                                  return null;
                              },
                              // textInputAction: TextInputAction.newline,
                              // maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'I have to ...',
                                labelText: 'New ToDo',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  //* @required only shows warning not error
                                  final newToDo = ToDo(
                                    description: _todoDescriptionFormController
                                        .value.text,
                                  );
                                  if (newToDo.description.isNotEmpty) {
                                    todoBloc.addToDo(newToDo);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
