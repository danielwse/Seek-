import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Note {
  final message;
  final Color color;
  final DateTime createdAt;

  /// Instantiates a [Note].
  Note({
    this.message,
    this.color,
    DateTime createdAt,
  }) : this.createdAt = createdAt ?? DateTime.now();

  /// Transforms the Firestone query [snapshot] into a list of [Note] instances.
  static List<Note> fromQuery(QuerySnapshot snapshot) => snapshot != null ? toNotes(snapshot):[];
  }
  /// Transforms the query result into a list of notes.
  List<Note> toNotes(QuerySnapshot query) => query.documents
    .map((d) => toNote(d))
    .where((n) => n != null)
    .toList();

   /// Transforms a document into a single note.
   Note toNote(DocumentSnapshot doc) => doc.exists
    ? Note(
      message:doc.data['message'],
      color: _parseColor(doc.data['color']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(doc.data['createdAt'] ?? 0),
    )
    : null;

  Color _parseColor(num colorInt) => Color(colorInt ?? 0xFFFFFFFF);