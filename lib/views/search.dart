// @dart=2.9

import 'package:flutter/material.dart';
import 'package:todolist_app/designs/note_design.dart';
import 'package:todolist_app/process/database.dart';
import 'package:todolist_app/widgets/load.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _textEditingController = TextEditingController();

  List<Note> notesOnSearch = [];
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
        title: Container(
          decoration: BoxDecoration(color: Colors.blue.shade100),
          child: TextField(
            onChanged: (value) {
              setState(() {
                notesOnSearch = notes
                    .where((element) => element
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(5),
              hintText: 'Search Notes',
            ),
          ),
        ),
      ),
      body: loading
          ? Loading()
          : ListView.builder(
              padding: EdgeInsets.all(5.2),
              itemCount: _textEditingController.text.isNotEmpty
                  ? notesOnSearch.length
                  : notes.length,
              itemBuilder: (context, index) {
                Note note = _textEditingController.text.isNotEmpty
                    ? notesOnSearch[index]
                    : notes[index];
                return Card(
                  color: Colors.white70,
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }),
    );
  }

  Future<void> refresh() async {
    notes = await DB().getNotes();
    setState(() => loading = false);
  }
}
