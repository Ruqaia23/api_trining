import 'dart:convert';
import 'package:api_trining/bottomsheet.dart';
import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_trining/Apis/appapis.dart';

import 'widget/button_appber_post.widget.dart';
import 'widget/card_post.widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts = [];
  bool isLoading = false;
  AppAPIs appAPIs = AppAPIs();

  // final Future<String>  = Future<String>.delayed(
  //   const Duration(seconds: 2),
  //   () => '',
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
      ),
      body: Column(
        children: [
          Center(
            child: FutureBuilder(
              future: appAPIs.dataCall(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  snapshot.data!;
                  print(snapshot.data);

                  return ButtonAppberPost(
                    onAddPost: _addPost,
                    onGetPosts: _getPosts,
                  );
                } else {
                  return posts.length == 0
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                return CardPost(
                                  post: posts[index],
                                  onDeletePost: (post) {},
                                  onUpdatePost: (post) {},
                                );
                              }));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addPost() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          AddOrUpdatePostWidget(onAccept: (post) async {
        await appAPIs.createPost(
          title: post.title ?? "not title",
          body: post.body ?? "not body",
        );
      }),
    );
  }

  void _getPosts() {
    setState(() {
      isLoading = true;
    });
    appAPIs.dataCall().then((posts) {
      this.posts = posts;
      isLoading = false;
      setState(() {});
    });
  }
}
