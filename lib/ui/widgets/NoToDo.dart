import 'package:flutter/material.dart';

Widget noToDoMessageWidget() {
  return Container(
    child: Text(
      "Empty ToDo List",
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    ),
  );
}
