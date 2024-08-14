import 'package:api_trining/Apis/appapis.dart';
import 'package:api_trining/bottomsheet.dart';
import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';

class CardPost extends StatefulWidget {
  const CardPost({
    required this.post,
    required this.onDeletePost,
    required this.onUpdatePost,
  });

  final void Function(Post) onDeletePost;
  final void Function(Post) onUpdatePost;
  final Post post;

  @override
  State<CardPost> createState() => _CardPostState();
}

class _CardPostState extends State<CardPost> {
  AppAPIs appAPIs = AppAPIs();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.post.title ?? "--"),
        subtitle: Text(widget.post.body ?? "--"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(context),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editPost(),
            ),
          ],
        ),
      ),
    );
  }

  _editPost() {}

  void _confirmDelete(BuildContext context) {
    appAPIs.deletePost(context, 1);
    setState(() {});

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => AlertDialog(
    //     title: Text('Delete'),
    //     actions: [
    //       TextButton(
    //         child: Text('Yes'),
    //         onPressed: () {
    //           appAPIs.deletePost(context, 1);
    //            Navigator.pop(context);
    //           setState(() {});
    //         },
    //       ),
    //       TextButton(
    //         child: Text('No'),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
