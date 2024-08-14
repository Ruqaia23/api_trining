import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';

class CardPost extends StatelessWidget {
  const CardPost(
      {super.key,
      required this.post,
      required this.onDeletePost,
      required this.onUpdatePost});
  final void Function(Post) onDeletePost;
  final void Function(Post) onUpdatePost;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title ?? "--"),
        subtitle: Text(post.body ?? "--"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDeletePost(post),
            ),
            IconButton(
                icon: const Icon(Icons.edit),
                  onPressed: () =>onUpdatePost(post),),
          ],
        ),
      ),
    );
  }
}
