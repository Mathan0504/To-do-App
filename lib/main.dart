// @dart=2.9

import 'package:flutter/material.dart';
import 'package:todolist_app/views/notes_log.dart';

void main() => runApp(ToDoList());

class ToDoList extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo-List',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}