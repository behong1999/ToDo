import 'dart:core';

import 'package:flutter/foundation.dart';

class ToDo {
  int id;
  String description;
  bool isCompleted = false;

  ToDo({
    @required this.id,
    @required this.description,
    this.isCompleted = false,
  });

  factory ToDo.fromDatabaseJson(Map<String, dynamic> data) => ToDo(
      id: data['id'],
      description: data['description'],
      isCompleted: data['is_completed'] == 0 ? false : true);

  //* Used to convert a Todo object that is to be stored into the datbase in a form of JSON
  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "description": description,
        "is_completed": isCompleted == false ? 0 : 1,
      };
}
