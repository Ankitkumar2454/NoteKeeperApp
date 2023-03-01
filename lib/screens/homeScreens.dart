import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_fire/screens/note_editor.dart';
import 'package:notes_fire/screens/note_reader.dart';
import 'package:notes_fire/style/appStyle.dart';
import 'package:notes_fire/widgets/note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.maincolor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Note's"),
        centerTitle: true,
        backgroundColor: AppStyle.maincolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recents :",
              style: GoogleFonts.pacifico(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  // checking connection
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // if (snapshot.hasData) {
                  //   return GridView(
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2),
                  //     children: snapshot.data!.docs
                  //         .map((note) => noteCard(() {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         NoteReaderScreen(note)),
                  //               );
                  //             }, note))
                  //         .toList(),
                  //   );
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        int color_id =
                            Random().nextInt(AppStyle.cardsColor.length);
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        var dataSnapshot = snapshot.data!.docs[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoteReaderScreen(dataSnapshot)),
                            );
                          },
                          child: Card(
                            color: AppStyle.cardsColor[color_id],
                            child: ListTile(
                              title: Text(documentSnapshot["note_title"],
                                  style: AppStyle.mainTitle),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(documentSnapshot["creation_date"],
                                      style: AppStyle.dateTitle),
                                  Text(
                                    documentSnapshot["note_content"],
                                    style: AppStyle.mainContent,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return RichText(
                    text: const TextSpan(
                        text: "notes :",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: "world",
                          ),
                        ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteEditorScreen()),
          );
        },
        backgroundColor: AppStyle.accentcolor,
        label: Text("Add note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
