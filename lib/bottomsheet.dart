import 'dart:convert';

import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOrUpdatePostWidget extends StatefulWidget {
  AddOrUpdatePostWidget({super.key, required this.onAccept});
  final void Function(Post) onAccept;

  @override
  State<AddOrUpdatePostWidget> createState() => _AddOrUpdatePostWidgetState();
}

class _AddOrUpdatePostWidgetState extends State<AddOrUpdatePostWidget> {
  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

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
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onAccept(Post(
                    title: titleController.text,
                    body: bodyController.text,
                  ));

                  _showDialog('Successfully Add');
                },
                child: const Text("Add"),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                  String title = titleController.text;
                  String body = bodyController.text;
                  Post updatedPost = Post(
                    title: title,
                    body: body,
                  );
                  widget.onAccept(updatedPost);
                  Navigator.pop(context);

                  _showDialog('Successfully updated');
                },
                child: const Text("edit"),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(message),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }
}
