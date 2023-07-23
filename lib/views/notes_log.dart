// @dart=2.9

import 'package:flutter/material.dart';
import 'package:todolist_app/designs/note_design.dart';
import 'package:todolist_app/process/database.dart';
import 'package:todolist_app/views/search.dart';
import 'package:todolist_app/views/update_note.dart';
import 'package:todolist_app/widgets/load.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  List<Note> notes;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo-List'),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() => loading = true);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(note: new Note()))).then((v) {
            refresh();
          });
        }
      ),
      body: loading? Loading() : ListView.builder(
        padding: EdgeInsets.all(5.2),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          Note note = notes[index];
          return Card(
            color: Colors.white70,
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(
                  note.content,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                  setState(() => loading = true);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(note: note))).then((v) {
                    refresh();
                  });
              },
            ),
          );
        }
      ),
    );

  }

  Future<void> refresh() async {

    notes = await DB().getNotes();
    setState(() => loading = false);

  }

}