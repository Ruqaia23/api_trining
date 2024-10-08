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

  void _editPost() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => AddOrUpdatePostWidget(
        onAccept: (post) async {
          if (post.title?.isNotEmpty == true && post.body?.isNotEmpty == true) {
            await appAPIs.updatePost(
              postId: post.id!,
              title: '${post.body}',
              body: '${post.body}',
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill out all fields')),
            );
          }
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    appAPIs.deletePost(context, 1);
    setState(() {});
  }
}
