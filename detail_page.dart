import 'package:flutter/material.dart';
import '../models/note.dart';
import 'create_page.dart';

class DetailPage extends StatelessWidget {

  final Note note;

  DetailPage({
    required this.note,
  });

  void _delete(BuildContext context){

    showDialog(
      context: context,

      builder:(context)=>AlertDialog(

        title: Text("Confirmation"),

        content: Text(
          "Supprimer cette note ?"
        ),

        actions:[

          TextButton(
            onPressed:(){
              Navigator.pop(context);
            },
            child: Text("Annuler"),
          ),

          TextButton(
            onPressed:(){

              Navigator.pop(context);

              Navigator.pop(
                context,
                "deleted",
              );

            },
            child: Text("Supprimer"),
          ),

        ],
      ),
    );
  }


  void _edit(BuildContext context) async {

    final updatedNote =
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:(context)=>
         CreateNotePage(
           note: note,
         ),
      ),
    );

    if(updatedNote!=null){

      Navigator.pop(
        context,
        updatedNote,
      );

    }
  }


  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(

        backgroundColor:
          Color(note.couleur),

        title: Text("Détail"),

        actions:[

          IconButton(
            icon: Icon(Icons.edit),
            onPressed:(){
              _edit(context);
            },
          ),

          IconButton(
            icon: Icon(Icons.delete),
            onPressed:(){
              _delete(context);
            },
          ),

        ],
      ),

      body: Container(

        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Color(note.couleur),
              width:8,
            ),
          ),
        ),

        child: Padding(
          padding: EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
             CrossAxisAlignment.start,

            children:[

              Text(
                note.titre,

                style: TextStyle(
                  fontSize:24,
                  fontWeight:
                    FontWeight.bold,
                ),
              ),

              SizedBox(height:20),

              Text(
               "Créée le: ${note.dateCreation}",
              ),

              SizedBox(height:20),

              Text(
                note.contenu,
              ),

            ],
          ),
        ),
      ),
    );
  }
}