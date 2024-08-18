import 'package:flutter/material.dart';

class ButtonAppberPost extends StatelessWidget {
  const ButtonAppberPost({
    super.key,
    required this.onAddPost,
    //required this.onGetPosts
  });
  final VoidCallback onAddPost;
  //final VoidCallback onGetPosts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            // MaterialButton(
            //   color: const Color.fromARGB(255, 205, 135, 217),
            //   onPressed:
            //   onGetPosts,
            //   child: const Text("Get"),
            // ),
          ]),
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
