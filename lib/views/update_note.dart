// @dart=2.9

import 'package:flutter/material.dart';
import 'package:todolist_app/designs/note_design.dart';
import 'package:todolist_app/process/database.dart';
import 'package:todolist_app/widgets/load.dart';

class Edit extends StatefulWidget {

  final Note note;
  Edit ({ this.note });

  @override
  EditState createState() => EditState();

}

class EditState extends  State<Edit> {

  TextEditingController title, content;
  bool loading = false, editview = false;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    content = TextEditingController();
    if(widget.note.id != null) {
      editview = true;
      title.text = widget.note.title;
      content.text = widget.note.content;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(editview? 'Edit Note' : 'New Note'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              setState(() => loading = true);
              save();
              Navigator.pop(context);
            },
          ),
          if(editview) IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() => loading = true);
              delete();
            },
          ),
        ],
      ),
      body: loading? Loading() : ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Enter Title'
              ),
          ),
          SizedBox(height: 18.0),
          TextField(
            controller: content,
            decoration: InputDecoration(
                hintText: 'Enter Content'
            ),
            maxLines: 10,
          ),
        ],
      ),
    );

  }

  Future<void> save() async {
    if(title.text != '') {
      widget.note.title = title.text;
      widget.note.content = content.text;
      if(editview) await DB().update(widget.note);
      else await DB().add(widget.note);
    }
    setState(() => loading = false);
  }

  Future<void> delete() async {
    await DB().delete(widget.note);
    Navigator.pop(context);
  }

}