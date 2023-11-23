import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  Timestamp noteID;
  String noteTitle;
  String noteDescription;
  String noteCategory;
  bool isLoved;

  NoteModel({
    required this.noteID,
    required this.noteTitle,
    required this.noteDescription,
    required this.noteCategory,
    required this.isLoved,
  });

  Map<String, dynamic> toMap() {
    return {
      'note_id': noteID,
      'note_tilte': noteTitle,
      'note_description': noteDescription,
      'note_category': noteCategory,
      'isLoved': isLoved,
    };
  }

  NoteModel.fromDucumentSnapShot(DocumentSnapshot ref)
      : noteID = ref['note_id'],
        noteTitle = ref['note_title'],
        noteDescription = ref['note_description'],
        noteCategory = ref['note_category'],
        isLoved = ref['isLoved'];
}
