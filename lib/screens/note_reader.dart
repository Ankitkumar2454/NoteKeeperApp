import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_fire/style/appStyle.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();
    String date = DateTime.now().toString();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.cardsColor[color_id],
        appBar: AppBar(
          backgroundColor: AppStyle.cardsColor[color_id],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doc["note_title"],
                style: AppStyle.mainTitle,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                widget.doc["creation_date"],
                style: AppStyle.dateTitle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.doc["note_content"],
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // bottomNavigationBar: FloatingActionButton(
        //   child: Icon(Icons.edit),
        //   onPressed: () async {
        //     if (widget.doc != null) {
        //       _titleController.text = widget.doc["note_title"];
        //       _mainController.text = widget.doc["note_content"];
        //     }
        //     final String _title = _titleController.text;
        //     final String _content = _mainController.text;
        //     await showModalBottomSheet(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return Column(
        //           children: [
        //             TextField(
        //               controller: _titleController,
        //               decoration: const InputDecoration(labelText: 'title'),
        //             ),
        //             TextField(
        //               controller: _mainController,
        //               decoration: const InputDecoration(
        //                 labelText: 'content',
        //               ),
        //             ),
        //             ElevatedButton(
        //               onPressed: () {
        //                 FirebaseFirestore.instance
        //                     .collection("Notes")
        //                     .doc(widget.doc.id)
        //                     .update({
        //                   "note_title": _title,
        //                   "creation_date": widget.doc["creation_date"],
        //                   "note_content": _content
        //                 }).then((value) {
        //                   _titleController.text = '';
        //                   _mainController.text = '';
        //                   Navigator.pop(context);
        //                 }).catchError(
        //                   (error) => print("Failed to add due to $error"),
        //                 );
        //               },
        //               child: Text('Update'),
        //             )
        //           ],
        //         );
        //       },
        //     );
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection("Notes")
                .doc(widget.doc.id)
                .delete()
                .then((value) {
              Navigator.pop(context);
            }).catchError(
              (error) => print("Failed to add due to $error"),
            );
          },
          backgroundColor: AppStyle.maincolor,
          child: Icon(
            Icons.delete,
          ),
        ),
      ),
    );
  }
}
