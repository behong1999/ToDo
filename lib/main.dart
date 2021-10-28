import 'package:flutter/material.dart';
import 'package:to_do_bloc/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reactive Flutter',
      theme: ThemeData(
          primarySwatch: Colors.indigo, canvasColor: Colors.transparent),
      //Our only screen/page we have
      home: HomePage(title: 'My Todo List'),
    );
  }
}
