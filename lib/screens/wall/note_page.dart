import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:seek/screens/wall/add_note.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() {
    return _NotePageState();
  }
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Wall')),
      body: _buildBody(context),
      floatingActionButton: AddNote(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('wall').orderBy("timestamp", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final note = Note.fromSnapshot(data);

    return Padding(
      key: ValueKey(note.message),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(note.message),
        ),
      ),
    );
  }
}

class Note {
  final String title;
  final String message;
  final DocumentReference reference;

  Note.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['message'] != null),
        assert(map['title'] != null),
        title = map['title'],
        message = map['message'];

  Note.fromSnapshot(DocumentSnapshot snapshot) 
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  // @override
  // String toString() => "Note<$name:$numberOfAs>";
}

