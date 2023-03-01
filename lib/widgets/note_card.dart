import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_fire/style/appStyle.dart';

Widget noteCard(Function()? ontap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc["color_id"]],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["note_title"], style: AppStyle.mainTitle),
          SizedBox(
            height: 4,
          ),
          Text(doc["creation_date"], style: AppStyle.dateTitle),
          SizedBox(
            height: 4,
          ),
          Text(
            doc["note_content"],
            style: AppStyle.mainContent,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ],
      ),
    ),
  );
}
