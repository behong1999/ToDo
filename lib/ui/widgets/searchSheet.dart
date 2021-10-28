import 'package:flutter/material.dart';
import 'package:to_do_bloc/bloc/todo_bloc.dart';

void showToDoSearchSheet(BuildContext context, ToDoBloc todoBloc) {
  final _todoSearchDescriptionFormController = TextEditingController();
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
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _todoSearchDescriptionFormController,
                            // textInputAction: TextInputAction.newline,
                            // maxLines: 4,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: '',
                              labelText: 'Search',
                              labelStyle: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Null value';
                              }
                              return value.contains('@')
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, top: 15),
                          child: CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            radius: 18,
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                todoBloc.getToDosEvent(
                                    query: _todoSearchDescriptionFormController
                                        .value.text);
                                Navigator.pop(context);
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
        );
      });
}
