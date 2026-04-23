import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteService extends ChangeNotifier {

  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note){
    _notes.insert(0, note);
    notifyListeners();
  }

  void updateNote(Note note){
    int index = _notes.indexWhere((n) => n.id == note.id);

    if(index != -1){
      _notes[index] = note;
      notifyListeners();
    }
  }

  void deleteNote(String id){
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}