import 'dart:convert';

import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> showAddEditBottomSheet(BuildContext context) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                hintText: "Body",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    String title = titleController.text;
                    String body = bodyController.text;
                    Navigator.pop(context);
                    // return ({title,body})
                    //  createPost(title, body);
                  },
                  child: Text("add"),
                ),
                SizedBox(width: 15),

                ElevatedButton(
                  onPressed: () {
                    String title = titleController.text;
                    String body = bodyController.text;
                    // updatePost(title, body);
                    Navigator.pop(context);
                  },
                  child: Text("edit"),
                ),
              ]),
            )
          ],
        ),
      );
    },
  );
}
