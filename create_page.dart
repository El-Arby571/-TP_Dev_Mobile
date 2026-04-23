import 'package:flutter/material.dart';
import '../models/note.dart';

class CreateNotePage extends StatefulWidget {
  final Note? note;

  CreateNotePage({this.note});

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {

  TextEditingController titreController = TextEditingController();
  TextEditingController contenuController = TextEditingController();

  Color selectedColor = Colors.yellow;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titreController.text = widget.note!.titre;
      contenuController.text = widget.note!.contenu;
      selectedColor = Color(widget.note!.couleur);
    }
  }

  void save() {
    if (titreController.text.isEmpty) return;

    Note note = Note(
      id: widget.note?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      titre: titreController.text,
      contenu: contenuController.text,
      couleur: selectedColor.value,
      dateCreation: widget.note?.dateCreation ?? DateTime.now(),
      dateModification: DateTime.now(),
    );

    Navigator.pop(context, note);
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: CircleAvatar(
        backgroundColor: color,
        child: selectedColor == color
            ? Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null
            ? "Nouvelle Note"
            : "Modifier Note"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: titreController,
              decoration: InputDecoration(labelText: "Titre"),
            ),

            TextField(
              controller: contenuController,
              decoration: InputDecoration(labelText: "Contenu"),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                colorCircle(Colors.yellow),
                colorCircle(Colors.pink),
                colorCircle(Colors.green),
                colorCircle(Colors.blue),
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              child: Text("Sauvegarder"),
            )
          ],
        ),
      ),
    );
  }
}