import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_fire/style/appStyle.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  String date = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    print(date);
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new note",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note title",
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note content",
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": _mainController.text,
            "color_id": color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
            (error) => print("Failed to add due to $error"),
          );
        },
        backgroundColor: AppStyle.maincolor,
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }
}
