import 'package:flutter/material.dart';

class ButtonAppberPost extends StatelessWidget {
  const ButtonAppberPost({
    super.key,
    required this.onAddPost,
  });
  final VoidCallback onAddPost;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: []),
          const SizedBox(width: 20),
          MaterialButton(
            color: Color.fromARGB(255, 205, 135, 217),
            onPressed: onAddPost,
            child: Text("Add"),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
