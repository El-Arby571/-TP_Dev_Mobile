import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/note_service.dart';
import 'create_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
 @override
 _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 String sortType="recent";

 @override
 Widget build(BuildContext context){

   final notes=
   context.watch<NoteService>().notes;

   if(sortType=="az"){
      notes.sort(
       (a,b)=>a.titre.compareTo(b.titre)
      );
   }

   else if(sortType=="old"){
      notes.sort(
       (a,b)=>a.dateCreation.compareTo(
         b.dateCreation
       )
      );
   }

   else{
      notes.sort(
       (a,b)=>b.dateCreation.compareTo(
         a.dateCreation
       )
      );
   }

   return Scaffold(

    appBar: AppBar(
      title: Text("Mes Notes"),

      actions:[
       PopupMenuButton<String>(

        onSelected:(value){
         setState(() {
           sortType=value;
         });
        },

        itemBuilder:(context)=>[
         PopupMenuItem(
          value:"recent",
          child: Text("Date récente"),
         ),

         PopupMenuItem(
          value:"old",
          child: Text("Date ancienne"),
         ),

         PopupMenuItem(
          value:"az",
          child: Text("A → Z"),
         ),
        ],
       ),
      ],
    ),

    body: notes.isEmpty
    ? Center(
      child: Text("Aucune note"),
     )

    : ListView.builder(
      itemCount: notes.length,

      itemBuilder:(context,index){

        final note=notes[index];

        return Card(
          child: Container(

            decoration: BoxDecoration(
             border: Border(
              left: BorderSide(
               color: Color(note.couleur),
               width:6,
              ),
             ),
            ),

            child: ListTile(

              title: Text(note.titre),

              subtitle: Text(
               note.contenu.length>30
               ? note.contenu.substring(0,30)
               : note.contenu,
              ),

              onTap:() async {

               final result=
               await Navigator.push(
                context,
                MaterialPageRoute(
                 builder:(_)=>DetailPage(
                   note: note,
                 ),
                ),
               );

               if(result=="deleted"){

                context
                .read<NoteService>()
                .deleteNote(note.id);

               }

               else if(result!=null){

                context
                .read<NoteService>()
                .updateNote(result);

               }

              },
            ),
          ),
        );

      },
    ),

    floatingActionButton:
    FloatingActionButton(

      child: Icon(Icons.add),

      onPressed:() async {

       final note=
       await Navigator.push(
         context,
         MaterialPageRoute(
          builder:(_)=>CreateNotePage(),
         ),
       );

       if(note!=null){

         context
         .read<NoteService>()
         .addNote(note);

       }

      },
    ),

   );
 }
}