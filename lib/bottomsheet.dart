import 'dart:convert';

import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOrUpdatePostWidget extends StatelessWidget {
  AddOrUpdatePostWidget({super.key, required this.onAccept});
  final void Function(Post) onAccept;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: bodyController,
            decoration: const InputDecoration(
              hintText: "Body",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onAccept(Post(
                    title: titleController.text,
                    body: bodyController.text,
                  ));

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text('Successfully added'),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      );
                    },
                  );
                },
                child: const Text("Add"),
              ),
              const SizedBox(width: 15),

              ElevatedButton(
                onPressed: () {
                  String title = titleController.text;
                  String body = bodyController.text;

                  Navigator.pop(context);
                  onAccept(Post());
                },
                child: const Text("edit"),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
